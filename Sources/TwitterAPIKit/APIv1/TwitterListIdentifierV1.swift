import Foundation

public enum TwitterListIdentifierV1 {
    case listID(String)
    case slug(slug: String, owner: TwitterUserIdentifierV1)
}

extension TwitterListIdentifierV1 {
    func bind(param: inout [String: Any]) {
        switch self {
        case .listID(let string):
            param["list_id"] = string
        case .slug(let slug, let owner):
            param["slug"] = slug
            switch owner {
            case .userID(let string):
                param["owner_id"] = string
            case .screenName(let string):
                param["owner_screen_name"] = string
            }
        }
    }
}
