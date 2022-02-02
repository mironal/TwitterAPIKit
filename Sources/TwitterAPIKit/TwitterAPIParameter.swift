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

protocol TwitterAPIParameters {
    var parameters: [String: Any]? { get }
}
