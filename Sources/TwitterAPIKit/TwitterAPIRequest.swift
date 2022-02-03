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

public protocol TwitterAPIRequest {
    var method: HTTPMethod { get }
    var baseURLType: TwitterBaseURLType { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
}

extension TwitterAPIRequest {
    public var baseURLType: TwitterBaseURLType {
        return .api
    }
}
