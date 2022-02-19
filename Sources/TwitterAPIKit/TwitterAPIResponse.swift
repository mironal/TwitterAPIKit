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
    public var prettyString: String {

        let body =
            data.map { data in
                if let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) {
                    return String(data: jsonData, encoding: .utf8)?.unescapingUnicodeCharacters.unescapeSlash ?? ""
                } else {
                    return String(describing: data)
                }
            } ?? "No data"

        let rateLimitStr = rateLimit.map { String(describing: $0) } ?? "No rate limit"

        switch self.result {
        case .failure(let error):
            return "Failure => \(error.localizedDescription)"
                + "\n\(rateLimitStr)"
                + "\n\(body)"
        case .success:
            let url = response?.url?.absoluteString ?? "NULL URL"
            return "Success => \(url)\n\(rateLimitStr)\n\(body.unescapeSlash)"
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
