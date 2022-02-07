import Foundation

public enum TwitterUserIdentifier {
    case userID(String)
    case screenName(String)
}

// MARK: - extensions

extension TwitterUserIdentifier {
    func bind(param: inout [String: Any]) {
        switch self {
        case .userID(let string):
            param["user_id"] = string
        case .screenName(let string):
            param["screen_name"] = string
        }
    }
}
