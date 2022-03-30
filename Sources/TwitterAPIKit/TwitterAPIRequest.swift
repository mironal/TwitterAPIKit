import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"

    public var prefersQueryParameters: Bool {
        switch self {
        case .get, .delete:
            return true
        default:
            return false
        }
    }
}

public enum BodyContentType: String {
    case wwwFormUrlEncoded = "application/x-www-form-urlencoded"

    /// In this case use MultipartFormDataPart as a parameter
    /// example: UploadMediaAppendRequestV1.swift
    case multipartFormData = "multipart/form-data"
    case json = "application/json; charset=UTF-8"
}

public enum MultipartFormDataPart {
    case value(name: String, value: Any)  // value is stringified with "String(describing:)"
    case data(name: String, value: Data, filename: String, mimeType: String)

    var name: String {
        switch self {
        case .value(let name, _):
            return name
        case .data(let name, _, _, _):
            return name
        }
    }
}

extension MultipartFormDataPart: Equatable {
    public static func == (lhs: MultipartFormDataPart, rhs: MultipartFormDataPart) -> Bool {
        switch (lhs, rhs) {
        case let (.value(name: ln, value: lv), .value(name: rn, value: rv)):
            return ln == rn && type(of: lv) == type(of: rv) && String(describing: lv) == String(describing: rv)
        case let (
            .data(name: ln, value: lv, filename: lf, mimeType: lm),
            .data(name: rn, value: rv, filename: rf, mimeType: rm)
        ):
            return ln == rn
                && lv == rv
                && lf == rf
                && lm == rm
        default:
            return false
        }
    }
}

public protocol TwitterAPIRequest {
    var method: HTTPMethod { get }
    var baseURLType: TwitterBaseURLType { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    var queryParameters: [String: Any] { get }
    var bodyParameters: [String: Any] { get }
    var bodyContentType: BodyContentType { get }
}

extension TwitterAPIRequest {
    public var baseURLType: TwitterBaseURLType {
        return .api
    }

    public var bodyContentType: BodyContentType {
        return .wwwFormUrlEncoded
    }

    public var parameters: [String: Any] {
        return [:]
    }

    public var queryParameters: [String: Any] {
        if method.prefersQueryParameters {
            return parameters
        }
        return [:]
    }

    public var bodyParameters: [String: Any] {
        if !method.prefersQueryParameters {
            return parameters
        }
        return [:]
    }
}

extension TwitterAPIRequest {

    func buildRequest(environment: TwitterAPIEnvironment) throws -> URLRequest {

        guard
            var urlComponent = URLComponents(
                url: requestURL(for: environment),
                resolvingAgainstBaseURL: true
            )
        else {
            throw TwitterAPIKitError.requestFailed(reason: .invalidURL(url: ""))
        }
        if !queryParameters.isEmpty {
            urlComponent.percentEncodedQueryItems =
                queryParameters
                .sorted(by: { a, b in a.key < b.key })
                .map { .init(name: $0.urlEncodedString, value: "\($1)".urlEncodedString) }
        }

        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = method.rawValue

        if !bodyParameters.isEmpty {

            switch bodyContentType {
            case .wwwFormUrlEncoded:
                request.setValue(bodyContentType.rawValue, forHTTPHeaderField: "Content-Type")
                let query = bodyParameters.urlEncodedQueryString
                guard let data = query.data(using: .utf8) else {
                    throw TwitterAPIKitError.requestFailed(reason: .cannotEncodeStringToData(string: query))
                }
                request.httpBody = data
            case .multipartFormData:

                guard let parts = Array(bodyParameters.values) as? [MultipartFormDataPart] else {
                    throw TwitterAPIKitError.requestFailed(
                        reason: .invalidParameter(
                            parameter: bodyParameters,
                            cause:
                                "Parameter must be specified in `MultipartFormDataPart` for `BodyContentType.multipartFormData`."
                        ))
                }

                let boundary = "TwitterAPIKit-\(UUID().uuidString)"
                let contentType = "\(BodyContentType.multipartFormData.rawValue); boundary=\(boundary)"
                request.setValue(contentType, forHTTPHeaderField: "Content-Type")

                request.httpBody = try multipartFormData(
                    boundary: boundary, parts: parts.sorted(by: { $0.name < $1.name }))
                request.setValue(
                    String(request.httpBody?.count ?? 0), forHTTPHeaderField: "Content-Length")
            case .json:

                let param = bodyParameters
                guard JSONSerialization.isValidJSONObject(param) else {
                    throw TwitterAPIKitError.requestFailed(reason: .jsonSerializationFailed(obj: param))
                }
                do {
                    request.httpBody = try JSONSerialization.data(
                        withJSONObject: param, options: []
                    )
                    request.setValue(bodyContentType.rawValue, forHTTPHeaderField: "Content-Type")

                } catch {
                    // This path probably won't pass because it is pre-checked with `isValidJSONObject`.
                    throw TwitterAPIKitError.requestFailed(reason: .jsonSerializationFailed(obj: param))
                }
            }
        }
        return request
    }

    func requestURL(for environment: TwitterAPIEnvironment) -> URL {
        return environment.baseURL(for: baseURLType).appendingPathComponent(path)
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

    private func multipartFormData(boundary: String, parts: [MultipartFormDataPart]) throws -> Data {
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
}

extension TwitterAPIEnvironment {
    fileprivate func baseURL(for type: TwitterBaseURLType) -> URL {
        switch type {
        case .twitter: return twitterURL
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
