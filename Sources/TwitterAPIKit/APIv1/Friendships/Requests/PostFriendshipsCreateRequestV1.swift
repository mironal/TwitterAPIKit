import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/post-friendships-create
open class PostFriendshipsCreateRequestV1: TwitterAPIRequest {

    public let user: TwitterUserIdentifierV1
    public let follow: Bool?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/friendships/create.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        user.bind(param: &p)
        follow.map { p["follow"] = $0 }
        return p
    }

    public init(
        user: TwitterUserIdentifierV1,
        follow: Bool? = .none
    ) {
        self.user = user
        self.follow = follow
    }
}
