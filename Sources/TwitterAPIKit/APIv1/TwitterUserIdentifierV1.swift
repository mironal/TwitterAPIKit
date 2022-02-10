import Foundation

public enum TwitterUserIdentifierV1 {
    case userID(String)
    case screenName(String)
}

public enum TwitterUsersIdentifierV1 {
    case userIDs([String])
    case screenNames([String])
}

// MARK: - extensions

extension TwitterUserIdentifierV1 {
    func bind(param: inout [String: Any]) {
        switch self {
        case .userID(let string):
            param["user_id"] = string
        case .screenName(let string):
            param["screen_name"] = string
        }
    }
}

extension TwitterUsersIdentifierV1 {
    func bind(param: inout [String: Any]) {
        switch self {
        case .userIDs(let array):
            param["user_id"] = array.joined(separator: ",")
        case .screenNames(let array):
            param["screen_name"] = array.joined(separator: ",")
        }
    }
}
