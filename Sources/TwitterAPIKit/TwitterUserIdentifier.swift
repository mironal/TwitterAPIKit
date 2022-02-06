import Foundation

public enum TwitterUserIdentifier {
    case userID(String)
    case screenName(String)
}

// MARK: - extensions

extension TwitterUserIdentifier {
    func apiKeyValue(_ block: (_ key: String, _ value: String) -> Void) {
        switch self {
        case .userID(let string):
            block("user_id", string)
        case .screenName(let string):
            block("screen_name", string)
        }
    }
}
