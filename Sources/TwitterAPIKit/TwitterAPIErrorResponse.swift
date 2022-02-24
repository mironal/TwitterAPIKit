import Foundation

public enum TwitterAPIErrorResponse {
    case v1(TwitterAPIErrorResponseV1)
    case v2(TwitterAPIErrorResponseV2)
    case unknown(Data)

    init(data: Data) {
        guard let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            self = .unknown(data)
            return
        }

        if let v1 = TwitterAPIErrorResponseV1(obj: obj) {
            self = .v1(v1)
        } else if let v2 = TwitterAPIErrorResponseV2(obj: obj) {
            self = .v2(v2)
        } else {
            self = .unknown(data)
        }
    }
}

extension TwitterAPIErrorResponse {
    var message: String {
        switch self {
        case .v1(let twitterAPIErrorResponseV1):
            return twitterAPIErrorResponseV1.message
        case .v2(let twitterAPIErrorResponseV2):
            return twitterAPIErrorResponseV2.detail
        case .unknown(let data):
            return String(data: data, encoding: .utf8) ?? "Unknown"
        }
    }
}

/// https://developer.twitter.com/ja/docs/basics/response-codes
public struct TwitterAPIErrorResponseV1 {

    /// first error message
    public let message: String
    /// first error code
    public let code: Int
    public let errors: [Self]

    public init(message: String, code: Int, errors: [Self]) {
        self.message = message
        self.code = code
        self.errors = errors
    }

    /// {"errors":[{"message":"Sorry, that page does not exist","code":34}]}
    public init?(obj: [String: Any]) {
        guard let errors = obj["errors"] as? [[String: Any]] else {
            return nil
        }

        let tErrors: [TwitterAPIErrorResponseV1] = errors.compactMap { error in
            guard let message = error["message"] as? String, let code = error["code"] as? Int else { return nil }
            return TwitterAPIErrorResponseV1(message: message, code: code, errors: [])
        }

        guard !tErrors.isEmpty else {
            return nil
        }

        self.message = tErrors[0].message
        self.code = tErrors[0].code
        self.errors = tErrors
    }

    var isValid: Bool {
        return !errors.isEmpty
    }

    public func contains(code: Int) -> Bool {
        return errors.contains(where: { $0.code == code })
    }
}

/// https://developer.twitter.com/en/support/twitter-api/error-troubleshooting
public struct TwitterAPIErrorResponseV2 {

    public struct Error {
        public let message: String
        public let parameter: [String /* paramter name */: [String] /* values */]

        init(obj: [String: Any]) {
            message = obj["message"].map { String(describing: $0) } ?? ""
            parameter = (obj["parameters"] as? [String: [String]]) ?? [:]
        }
    }

    public let title: String
    public let detail: String
    public let type: String
    public let errors: [Error]

    public init?(obj: [String: Any]) {

        guard let title = obj["title"] as? String,
            let detail = obj["detail"] as? String,
            let type = obj["type"] as? String
        else {
            return nil
        }

        self.title = title
        self.detail = detail
        self.type = type
        errors = ((obj["errors"] as? [[String: Any]]) ?? []).map { Error(obj: $0) }
    }
}
