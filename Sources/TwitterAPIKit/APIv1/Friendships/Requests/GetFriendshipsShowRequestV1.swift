import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-show
open class GetFriendshipsShowRequestV1: TwitterAPIRequest {

    public let sourceUser: TwitterUserIdentifierV1
    public let targetUser: TwitterUserIdentifierV1

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/friendships/show.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        sourceUser.bind(param: &p, userIDKey: "source_id", screenNameKey: "source_screen_name")
        targetUser.bind(param: &p, userIDKey: "target_id", screenNameKey: "target_screen_name")
        return p
    }

    public init(
        sourceUser: TwitterUserIdentifierV1,
        targetUser: TwitterUserIdentifierV1
    ) {
        self.sourceUser = sourceUser
        self.targetUser = targetUser
    }
}
