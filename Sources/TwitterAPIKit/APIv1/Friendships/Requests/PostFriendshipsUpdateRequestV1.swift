import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/post-friendships-update
open class PostFriendshipsUpdateRequestV1: TwitterAPIRequest {

    public let user: TwitterUserIdentifierV1
    public let device: Bool?
    public let retweets: Bool?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/friendships/update.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        user.bind(param: &p)
        device.map { p["device"] = $0 }
        retweets.map { p["retweets"] = $0 }
        return p
    }

    public init(
        user: TwitterUserIdentifierV1,
        device: Bool? = .none,
        retweets: Bool? = .none
    ) {
        self.user = user
        self.device = device
        self.retweets = retweets
    }
}
