import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-create
open class PostListsCreateRequestV1: TwitterAPIRequest {

    public let name: String
    public let mode: TwitterListModeV1?
    public let description: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/lists/create.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["name"] = name
        mode?.bind(param: &p)
        description.map { p["description"] = $0 }
        return p
    }

    public init(
        name: String,
        mode: TwitterListModeV1? = .none,
        description: String? = .none
    ) {
        self.name = name
        self.mode = mode
        self.description = description
    }
}
