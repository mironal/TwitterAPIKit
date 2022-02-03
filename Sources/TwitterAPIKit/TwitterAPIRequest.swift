import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
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
    case json = "application/json"
}

public protocol TwitterAPIRequest {
    var method: HTTPMethod { get }
    var baseURLType: TwitterBaseURLType { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var bodyContentType: BodyContentType { get }
}

extension TwitterAPIRequest {
    public var baseURLType: TwitterBaseURLType {
        return .api
    }

    public var bodyContentType: BodyContentType {
        return .wwwFormUrlEncoded
    }
}
