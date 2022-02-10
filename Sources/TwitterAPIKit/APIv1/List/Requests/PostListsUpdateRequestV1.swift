import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-update
open class PostListsUpdateRequestV1: TwitterAPIRequest {

    public let list: TwitterListIdentifierV1
    public let name: String?
    public let mode: TwitterListModeV1?
    public let description: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/lists/update.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        list.bind(param: &p)
        name.map { p["name"] = $0 }
        mode?.bind(param: &p)
        description.map { p["description"] = $0 }
        return p
    }

    public init(
        list: TwitterListIdentifierV1,
        name: String? = .none,
        mode: TwitterListModeV1? = .none,
        description: String? = .none
    ) {
        self.list = list
        self.name = name
        self.mode = mode
        self.description = description
    }
}
