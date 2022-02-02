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

protocol TwitterAPIParameter {
    var baseURL: URL { get }
    var method: HTTPMethod { get }

    var path: String { get }
    var parameters: [String: Any]? { get }
}

extension TwitterAPIParameter {
    public var baseURL: URL {
        return URL(string: "https://api.twitter.com")!
    }
}
