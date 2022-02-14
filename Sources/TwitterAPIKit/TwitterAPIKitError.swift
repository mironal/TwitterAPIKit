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
        case unacceptableStatusCode(code: Int, data: Data, rateLimit: TwitterRateLimit)
    }

    case responseSerializeFailed(reason: ResponseSerializationFailureReason)
    public enum ResponseSerializationFailureReason {
        case jsonSerializationFailed(error: Error, data: Data, rateLimit: TwitterRateLimit)
        case jsonDecodeFailed(error: Error, data: Data, rateLimit: TwitterRateLimit)
        case cannotConvert(data: Data, toTypeName: String)
    }
}

extension TwitterAPIKitError {

    var requestFailureReason: RequestFailureReason? {
        guard case .requestFailed(reason: let reason) = self else { return nil }
        return reason
    }

    var responseFailureReason: ResponseFailureReason? {
        guard case .responseFailed(let reason) = self else { return nil }
        return reason
    }

    var responseSerializationFailureReason: ResponseSerializationFailureReason? {
        guard case .responseSerializeFailed(let reason) = self else { return nil }
        return reason
    }
}
