import Foundation

open class TwitterAPISession {

    public let auth: TwitterAuthenticationMethod
    public let session: URLSession
    public let environment: TwitterAPIEnvironment

    public init(
        auth: TwitterAuthenticationMethod, session: URLSession = .shared, environment: TwitterAPIEnvironment
    ) {
        self.auth = auth
        self.session = session
        self.environment = environment
    }

    @discardableResult
    public func send(
        _ request: TwitterAPIRequest,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {

        var urlRequest: URLRequest
        do {
            urlRequest = try request.buildRequest(environment: environment)
        } catch let error as TwitterAPIKitError {
            completionHandler(.failure(error))
            return NoOpSessionTask()
        } catch {
            fatalError()
        }

        switch auth {
        case let .oauth(
            consumerKey: consumerKey,
            consumerSecret: consumerSecret,
            oauthToken: oauthToken,
            oauthTokenSecret: oauthTokenSecret
        ):

            let authHeader = authorizationHeader(
                for: request.method,
                url: request.requestURL(for: environment),
                parameters: request.parameterForOAuth,
                consumerKey: consumerKey,
                consumerSecret: consumerSecret,
                oauthToken: oauthToken,
                oauthTokenSecret: oauthTokenSecret
            )
            urlRequest.setValue(authHeader, forHTTPHeaderField: "Authorization")
        case let .basic(apiKey: apiKey, apiSecretKey: apiSecretKey):
            let credential = "\(apiKey):\(apiSecretKey)"
            guard let credentialData = credential.data(using: .utf8) else {
                completionHandler(
                    .failure(
                        TwitterAPIKitError.requestFailed(reason: .cannotEncodeStringToData(string: credential))
                    ))
                return NoOpSessionTask()
            }
            let credentialBase64 = credentialData.base64EncodedString(options: [])
            let basicAuth = "Basic \(credentialBase64)"
            urlRequest.setValue(basicAuth, forHTTPHeaderField: "Authorization")
        case let .bearer(token):
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let task = session.dataTask(with: urlRequest) { data, response, error in

            if let error = error {
                completionHandler(.failure(.responseFailed(reason: .responseError(error: error, response: response))))
                return
            }

            guard let httpResposne = response as? HTTPURLResponse else {
                return
            }

            let rateLimit = TwitterRateLimit(header: httpResposne.allHeaderFields)

            guard 200..<300 ~= httpResposne.statusCode else {
                completionHandler(
                    .failure(
                        .responseFailed(
                            reason: .unacceptableStatusCode(
                                statusCode: httpResposne.statusCode,
                                error: TwitterAPIErrorResponse(data: data ?? Data()),
                                rateLimit: rateLimit
                            )
                        )
                    )
                )
                return
            }

            completionHandler(.success((data ?? Data(), rateLimit, httpResposne)))
        }
        task.resume()

        return task
    }
}

extension TwitterAPIRequest {

    func requestURL(for environment: TwitterAPIEnvironment) -> URL {
        return environment.baseURL(for: baseURLType).appendingPathComponent(path)
    }

    func buildRequest(environment: TwitterAPIEnvironment) throws -> URLRequest {

        guard
            var urlComponent = URLComponents(
                url: requestURL(for: environment),
                resolvingAgainstBaseURL: true
            )
        else {
            throw TwitterAPIKitError.requestFailed(reason: .invalidURL(url: ""))
        }
        if method.prefersQueryParameters {
            urlComponent.queryItems = parameters.map { .init(name: $0, value: "\($1)") }
        }

        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = method.rawValue

        if !method.prefersQueryParameters {

            switch bodyContentType {
            case .wwwFormUrlEncoded:
                request.setValue(bodyContentType.rawValue, forHTTPHeaderField: "Content-Type")
                let query = parameters.urlEncodedQueryString
                guard let data = query.data(using: .utf8) else {
                    throw TwitterAPIKitError.requestFailed(reason: .cannotEncodeStringToData(string: query))
                }
                request.httpBody = data
            case .multipartFormData:

                guard let parts = Array(parameters.values) as? [MultipartFormDataPart] else {
                    throw TwitterAPIKitError.requestFailed(
                        reason: .invalidParameter(
                            parameter: parameters,
                            cause:
                                "Parameter must be specified in `MultipartFormDataPart` for `BodyContentType.multipartFormData`."
                        ))
                }

                let boundary = "TwitterAPIKit-\(UUID().uuidString)"
                let contentType = "\(BodyContentType.multipartFormData.rawValue); boundary=\(boundary)"
                request.setValue(contentType, forHTTPHeaderField: "Content-Type")

                request.httpBody = try multipartFormData(boundary: boundary, parts: parts)
                request.setValue(
                    String(request.httpBody?.count ?? 0), forHTTPHeaderField: "Content-Length")
            case .json:
                request.setValue(bodyContentType.rawValue, forHTTPHeaderField: "Content-Type")
                do {
                    request.httpBody = try JSONSerialization.data(
                        withJSONObject: parameters, options: []
                    )
                } catch let error {
                    throw TwitterAPIKitError.requestFailed(reason: .jsonSerializationFailed(error: error))
                }
            }
        }
        return request
    }

    func multipartFormData(boundary: String, parts: [MultipartFormDataPart]) throws -> Data {
        // https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types#multipartform-data

        var body = Data()

        let boundaryDelimiter = "--\(boundary)"
        let lineBreak = "\r\n"

        for part in parts {
            try body.appendBody(boundaryDelimiter)
            try body.appendBody(lineBreak)

            switch part {
            case let .value(name: name, value: value):
                try body.appendBody("Content-Disposition: form-data; name=\"\(name)\"")
                try body.appendBody(lineBreak)
                try body.appendBody(lineBreak)
                try body.appendBody(String(describing: value))
                try body.appendBody(lineBreak)

            case let .data(name: name, value: value, filename: filename, mimeType: mimeType):
                try body.appendBody(
                    "Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\""
                )
                try body.appendBody(lineBreak)
                if !mimeType.isEmpty {
                    try body.appendBody("Content-Type: \(mimeType)")
                }
                try body.appendBody(lineBreak)
                try body.appendBody(lineBreak)
                body.append(value)
                try body.appendBody(lineBreak)
            }
        }
        try body.appendBody(boundaryDelimiter)
        try body.appendBody("--")
        try body.appendBody(lineBreak)

        return body
    }

    var parameterForOAuth: [String: Any] {
        switch bodyContentType {
        case .wwwFormUrlEncoded:
            return parameters
        case .json, .multipartFormData:
            // parameter is empty
            return [:]
        }
    }
}

extension TwitterAPIEnvironment {
    func baseURL(for type: TwitterBaseURLType) -> URL {
        switch type {
        case .api: return apiURL
        case .upload: return uploadURL
        }
    }
}

extension Data {
    fileprivate mutating func appendBody(_ string: String) throws {
        if let data = string.data(using: .utf8) {
            append(data)
        } else {
            throw TwitterAPIKitError.requestFailed(reason: .cannotEncodeStringToData(string: string))
        }
    }
}
