import Foundation

public enum TwitterAPIKitError: Error {

    case requestFailed(reason: RequestFailureReason)
    public enum RequestFailureReason {
        case invalidURL(url: String)
        case invalidParameter(parameter: [String: Any], cause: String)

        case cannotEncodeStringToData(string: String)
        case jsonSerializationFailed(obj: Any)
    }

    case responseFailed(reason: ResponseFailureReason)
    public enum ResponseFailureReason {
        case invalidResponse(error: Error?)
        case unacceptableStatusCode(statusCode: Int, error: TwitterAPIErrorResponse, rateLimit: TwitterRateLimit?)
    }

    case responseSerializeFailed(reason: ResponseSerializationFailureReason)
    public enum ResponseSerializationFailureReason {
        case jsonSerializationFailed(error: Error)
        case jsonDecodeFailed(error: Error)
        case cannotConvert(data: Data, toTypeName: String)
    }

    case uploadMediaFailed(reason: UploadMediaFailureReason)
    public enum UploadMediaFailureReason {
        case processingFailed(error: UploadMediaError)
    }

    case refreshOAuth20TokenFailed(reason: RefreshOAuth20TokenFailureReason)
    public enum RefreshOAuth20TokenFailureReason {
        case invalidAuthenticationMethod(TwitterAuthenticationMethod)
        case refreshTokenIsMissing
    }

    case unkonwn(error: Error)

    public init(error: Error) {
        if let error = error as? TwitterAPIKitError {
            self = error
        } else {
            self = .unkonwn(error: error)
        }
    }
}

extension TwitterAPIKitError {
    public var isRequestFailed: Bool {
        if case .requestFailed = self { return true }
        return false
    }

    public var isResponseFailed: Bool {
        if case .responseFailed = self { return true }
        return false
    }

    public var isResponseSerializeFailed: Bool {
        if case .responseSerializeFailed = self { return true }
        return false
    }

    public var isUploadMediaFailed: Bool {
        if case .uploadMediaFailed = self { return true }
        return false
    }

    public var isRefreshOAuth20TokenFailed: Bool {
        if case .refreshOAuth20TokenFailed = self { return true }
        return false
    }

    public var isUnkonwn: Bool {
        if case .unkonwn = self { return true }
        return false
    }

    public var underlyingError: Error? {
        switch self {
        case .requestFailed(let reason):
            return reason.underlyingError
        case .responseFailed(let reason):
            return reason.underlyingError
        case .responseSerializeFailed(let reason):
            return reason.underlyingError
        case .uploadMediaFailed(let reason):
            return reason.underlyingError
        case .refreshOAuth20TokenFailed(let reason):
            return reason.underlyingError
        case .unkonwn(let error):
            return error
        }
    }

    public var isCancelled: Bool {
        guard let error = underlyingError as? URLError else {
            return false
        }
        return error.code == .cancelled
    }
}

extension TwitterAPIKitError {
    public struct UploadMediaError: Decodable, Error {
        public let code: Int
        public let name: String
        public let message: String

        public init(code: Int, name: String, message: String) {
            self.code = code
            self.name = name
            self.message = message
        }
    }
}

extension TwitterAPIKitError: LocalizedError {
    public var errorDescription: String? {

        switch self {
        case .requestFailed(let reason):
            return reason.localizedDescription
        case .responseFailed(let reason):
            return reason.localizedDescription
        case .responseSerializeFailed(let reason):
            return reason.localizedDescription
        case .uploadMediaFailed(let reason):
            return reason.localizedDescription
        case .refreshOAuth20TokenFailed(let reason):
            return reason.localizedDescription
        case .unkonwn(let error):
            return error.localizedDescription
        }
    }
}

extension TwitterAPIKitError.UploadMediaError: LocalizedError {
    public var errorDescription: String? {
        return "\(name)[code:\(code)]: \(message)"
    }
}

extension TwitterAPIKitError.RequestFailureReason {
    public var localizedDescription: String {
        switch self {
        case .invalidURL(let url):
            return "URL is not valid: \(url)"
        case .invalidParameter(let parameter, let cause):
            return "Parameter is not valid: \(parameter), cause: \(cause)"
        case .cannotEncodeStringToData(let string):
            return "Could not encode \"\(string)\""
        case .jsonSerializationFailed(let obj):
            return "JSON could not be serialized. May be invalid object \(String(describing: obj))"
        }
    }

    public var underlyingError: Error? {
        switch self {
        case .invalidURL,
            .invalidParameter,
            .cannotEncodeStringToData,
            .jsonSerializationFailed:
            return nil
        }
    }
}

extension TwitterAPIKitError.ResponseFailureReason {
    public var localizedDescription: String {
        switch self {
        case let .invalidResponse(error: error):
            if let error = error {
                return "Response is invalid: \(error.localizedDescription)"
            }
            return "Response is invalid"
        case let .unacceptableStatusCode(statusCode, error: error, rateLimit: _):
            return "Response status code was unacceptable: \(statusCode) with message: \(error.message)"
        }
    }

    public var underlyingError: Error? {
        switch self {
        case let .invalidResponse(error: error):
            return error
        case .unacceptableStatusCode(statusCode: _, error: _, rateLimit: _):
            return nil
        }
    }

    /// A status code in the case of unacceptableStatusCode.
    public var statusCode: Int? {
        if case .unacceptableStatusCode(statusCode: let statusCode, error: _, rateLimit: _) = self {
            return statusCode
        }
        return nil
    }

    /// A rate limit in the case of unacceptableStatusCode.
    public var rateLimit: TwitterRateLimit? {
        if case .unacceptableStatusCode(statusCode: _, error: _, rateLimit: let rateLimit) = self {
            return rateLimit
        }
        return nil
    }
}

extension TwitterAPIKitError.ResponseSerializationFailureReason {
    public var localizedDescription: String {
        switch self {
        case .jsonSerializationFailed(let error):
            return "Response could not be serialized because of error:\n\(error.localizedDescription)"
        case .jsonDecodeFailed(let error):
            return "Response could not be decoded because of error:\n\(error.localizedDescription)"
        case .cannotConvert(data: _, let toTypeName):
            return "Response could not convert to \"\(toTypeName)\""
        }
    }

    public var underlyingError: Error? {
        switch self {
        case let .jsonSerializationFailed(error: error),
            let .jsonDecodeFailed(error: error):
            return error
        case .cannotConvert:
            return nil
        }
    }
}

extension TwitterAPIKitError.UploadMediaFailureReason {
    public var localizedDescription: String {
        switch self {
        case .processingFailed(let error):
            return error.message
        }
    }

    public var underlyingError: Error? {
        switch self {
        case let .processingFailed(error: error):
            return error
        }
    }
}

extension TwitterAPIKitError.RefreshOAuth20TokenFailureReason {
    public var localizedDescription: String {
        switch self {
        case .invalidAuthenticationMethod(let method):
            return
                "Token refresh is possible only when TwitterAuthenticationMethod is .oauth20. You are currently \(method)."
        case .refreshTokenIsMissing:
            return "Refresh token is missing."
        }
    }
    public var underlyingError: Error? {
        switch self {
        case .invalidAuthenticationMethod, .refreshTokenIsMissing:
            return nil
        }
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

    public var refreshOAuth20TokenFailureReason: RefreshOAuth20TokenFailureReason? {
        guard case .refreshOAuth20TokenFailed(let reason) = self else { return nil }
        return reason
    }
}
