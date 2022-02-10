import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/post-friendships-destroy
open class PostFriendshipsDestroyRequestV1: TwitterAPIRequest {

    public let user: TwitterUserIdentifierV1

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/friendships/destroy.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        user.bind(param: &p)
        return p
    }

    public init(
        user: TwitterUserIdentifierV1
    ) {
        self.user = user
    }
}
