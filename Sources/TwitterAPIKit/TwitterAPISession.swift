import Foundation

public enum TwitterAPIKitError: Error {
    case connectionError(Error?, Data?, URLResponse?)

    case requestError(Error, Data?, HTTPURLResponse)

    case unacceptableStatusCode(code: Int, Data?, HTTPURLResponse)

    public var data: Data? {
        switch self {
        case .connectionError(_, let data, _),
            .requestError(_, let data, _),
            .unacceptableStatusCode(code: _, let data, _):
            return data
        }
    }
}

open class TwitterAPISession {

    public let auth: TwitterAPIAuth
    public let session: URLSession
    public let environment: TwitterAPIEnvironment

    public init(
        auth: TwitterAPIAuth, session: URLSession = .shared, environment: TwitterAPIEnvironment
    ) {
        self.auth = auth
        self.session = session
        self.environment = environment
    }

    public func send(
        _ request: TwitterAPIRequest,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        var urlRequest = request.buildRequest(environment: environment)

        switch auth {
        case let .oauth(
            consumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: oauthToken,
            oauthTokenSecret: oauthTokenSecret):
            let authHeader = authorizationHeader(
                for: request.method,
                url: environment.baseURL.appendingPathComponent(request.path),
                parameters: request.parameters ?? [:],
                isMediaUpload: false /* TODO*/,
                consumerKey: consumerKey,
                consumerSecret: consumerSecret,
                oauthToken: oauthToken,
                oauthTokenSecret: oauthTokenSecret
            )
            urlRequest.setValue(authHeader, forHTTPHeaderField: "Authorization")
        }

        let task = session.dataTask(with: urlRequest) { data, response, error in

            // May be "Error Domain=NSURLErrorDomain Code=-1009 The Internet connection appears to be offline."
            guard let httpResposne = response as? HTTPURLResponse else {
                return completionHandler(.failure(.connectionError(error, data, response)))
            }

            if let error = error {
                completionHandler(.failure(.requestError(error, data, httpResposne)))
            }

            guard 200..<300 ~= httpResposne.statusCode else {
                completionHandler(
                    .failure(
                        .unacceptableStatusCode(code: httpResposne.statusCode, data, httpResposne)
                    )
                )
                return
            }

            completionHandler(.success((data ?? Data(), httpResposne)))
        }
        task.resume()

        return task
    }

}

extension TwitterAPIRequest {
    func buildRequest(environment: TwitterAPIEnvironment) -> URLRequest {

        var urlComponent = URLComponents(
            url: environment.baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)!

        if method.prefersQueryParameters, let parameters = parameters {
            urlComponent.queryItems = parameters.map { .init(name: $0, value: "\($1)") }
        }

        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = method.rawValue

        if !method.prefersQueryParameters,
            let parameters = parameters,
            let body = parameters.urlEncodedQueryString.data(using: .utf8)
        {
            request.httpBody = body
        }
        return request
    }
}
