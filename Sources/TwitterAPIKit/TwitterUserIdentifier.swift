import Foundation

public enum TwitterUserIdentifier {
    case userID(String)
    case screenName(String)
}

public enum TwitterUsersIdentifier {
    case userIDs([String])
    case screenNames([String])
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

extension TwitterUsersIdentifier {
    func bind(param: inout [String: Any]) {
        switch self {
        case .userIDs(let array):
            param["user_id"] = array.joined(separator: ",")
        case .screenNames(let array):
            param["screen_name"] = array.joined(separator: ",")
        }
    }
}
