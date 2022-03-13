import Foundation

public struct TwitterAPIResponse<Success> {
    public let request: URLRequest?
    public let response: HTTPURLResponse?

    public let data: Data?
    public let result: Result<Success, TwitterAPIKitError>
    public let rateLimit: TwitterRateLimit?

    public var success: Success? { return result.success }
    public var error: TwitterAPIKitError? { return result.error }
    public var isError: Bool { return error != nil }

    public init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        result: Result<Success, TwitterAPIKitError>,
        rateLimit: TwitterRateLimit?
    ) {
        self.request = request
        self.response = response
        self.data = data
        self.result = result
        self.rateLimit = rateLimit
    }
}

extension TwitterAPIResponse {

    public func map<NewSuccess>(_ transform: (Success) -> NewSuccess) -> TwitterAPIResponse<NewSuccess> {
        return .init(
            request: request,
            response: response,
            data: data,
            result: result.map(transform),
            rateLimit: rateLimit
        )
    }

    public func flatMap<NewSuccess>(_ transform: (Success) -> Result<NewSuccess, TwitterAPIKitError>)
        -> TwitterAPIResponse<NewSuccess>
    {
        return .init(
            request: request,
            response: response,
            data: data,
            result: result.flatMap(transform),
            rateLimit: rateLimit
        )
    }

    public func tryMap<NewSuccess>(_ transform: (Success) throws -> NewSuccess) -> TwitterAPIResponse<NewSuccess> {
        let nextResult: Result<NewSuccess, TwitterAPIKitError> = result.flatMap { data in
            let r: Result<NewSuccess, Error> = .init {
                return try transform(data)
            }
            return r.mapError { TwitterAPIKitError(error: $0) }
        }
        return .init(
            request: request,
            response: response,
            data: data,
            result: nextResult,
            rateLimit: rateLimit
        )
    }

    public func mapError(_ tranform: (TwitterAPIKitError) -> TwitterAPIKitError) -> TwitterAPIResponse {
        return .init(
            request: request,
            response: response,
            data: data,
            result: result.mapError(tranform),
            rateLimit: rateLimit
        )

    }
}

extension TwitterAPIResponse {

    /// for debug
    public var prettyString: String {

        let body =
            data.map { data in

                // make pretty
                if let json = try? JSONSerialization.jsonObject(with: data, options: []),
                    let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                {
                    return String(data: jsonData, encoding: .utf8) ?? ""
                } else {
                    return String(data: data, encoding: .utf8) ?? "Invalid data"
                }
            } ?? "No data"

        let contentType = "> Content-Type: \(request?.allHTTPHeaderFields?["Content-Type"] ?? "No Content-Type")"
        let contentLength =
            "> Content-Length: \(request?.allHTTPHeaderFields?["Content-Length"] ?? "No Content-Length")"
        let request = "> \(request?.httpMethod?.uppercased() ?? "Unnown Method"): \(request?.url?.description ?? "")"
        let statusCode = "< Status code: \(response?.statusCode ?? 0)"
        let rateLimitStr = "< \(rateLimit.map { String(describing: $0) } ?? "No rate limit")"

        let responseContentType = "< Content-Type: \(response?.allHeaderFields["Content-Type"] ?? "No Content-Type")"
        let responseContentLength =
            "< Content-Length: \(response?.allHeaderFields["Content-Length"] ?? "No Content-Length")"

        switch self.result {
        case .failure(let error):
            return "-- Request failure --"
                + "\n\(request)"
                + "\n\(contentType)"
                + "\n\(contentLength)"
                + "\n\(statusCode)"
                + "\n\(responseContentType)"
                + "\n\(responseContentLength)"
                + "\n\(rateLimitStr)"
                + "\n\(error.localizedDescription)"
                + "\n<"
                + "\n\(body.count == 0 ? "Empty body" : body.unescapeSlash)"
        case .success:
            return "-- Request success --"
                + "\n\(request)"
                + "\n\(contentType)"
                + "\n\(contentLength)"
                + "\n\(statusCode)"
                + "\n\(responseContentType)"
                + "\n\(responseContentLength)"
                + "\n\(rateLimitStr)"
                + "\n<"
                + "\n\(body.count == 0 ? "Empty body" : body.unescapeSlash)"
        }
    }
}

extension String {

    fileprivate var unescapeSlash: String {
        return replacingOccurrences(of: #"\/"#, with: #"/"#)
    }

    fileprivate var unescapingUnicodeCharacters: String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, "Any-Hex/Java" as NSString, true)
        return mutableString as String
    }
}
