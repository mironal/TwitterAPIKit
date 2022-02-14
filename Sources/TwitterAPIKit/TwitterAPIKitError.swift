import Foundation

public enum TwitterAPIKitError: Error {

    case requestFailed(reason: RequestFailureReason)
    public enum RequestFailureReason {
        case invalidURL(url: String)
        case invalidParameter(parameter: [String: Any], cause: String)

        case cannotEncodeStringToData(string: String)
        case jsonSerializationFailed(error: Error)
    }

    case responseFailed(reason: ResponseFailureReason)
    public enum ResponseFailureReason {
        case responseError(error: Error, response: URLResponse?)
        case unacceptableStatusCode(code: Int, errors: [TwitterAPIError], rateLimit: TwitterRateLimit)
    }

    case responseSerializeFailed(reason: ResponseSerializationFailureReason)
    public enum ResponseSerializationFailureReason {
        case jsonSerializationFailed(error: Error, data: Data, rateLimit: TwitterRateLimit)
        case jsonDecodeFailed(error: Error, data: Data, rateLimit: TwitterRateLimit)
        case cannotConvert(data: Data, toTypeName: String)
    }
}

extension TwitterAPIKitError {

    public var requestFailureReason: RequestFailureReason? {
        guard case .requestFailed(reason: let reason) = self else { return nil }
        return reason
    }

    public var responseFailureReason: ResponseFailureReason? {
        guard case .responseFailed(let reason) = self else { return nil }
        return reason
    }

    public var responseSerializationFailureReason: ResponseSerializationFailureReason? {
        guard case .responseSerializeFailed(let reason) = self else { return nil }
        return reason
    }
}

/// https://developer.twitter.com/ja/docs/basics/response-codes
public struct TwitterAPIError: Error {
    //ex): {"errors":[{"message":"Sorry, that page does not exist","code":34}]}
    public static func fromErrors(data: Data) -> [TwitterAPIError] {
        guard let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return []
        }

        guard let errors = obj["errors"] as? [[String: Any]] else {
            return []
        }

        return errors.compactMap { error in
            guard let message = error["message"] as? String, let code = error["code"] as? Int else { return nil }
            return TwitterAPIError(message: message, code: code)
        }
    }

    public let message: String
    public let code: Int

    public init(message: String, code: Int) {
        self.message = message
        self.code = code
    }
}

extension Array where Element == TwitterAPIError {
    public func contains(code: Int) -> Bool {
        return contains(where: { $0.code == code })
    }
}
