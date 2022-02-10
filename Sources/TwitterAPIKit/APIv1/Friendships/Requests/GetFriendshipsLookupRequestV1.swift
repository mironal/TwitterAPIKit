import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-lookup
open class GetFriendshipsLookupRequestV1: TwitterAPIRequest {

    public let users: TwitterUsersIdentifierV1

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/friendships/lookup.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        users.bind(param: &p)
        return p
    }

    public init(
        users: TwitterUsersIdentifierV1
    ) {
        self.users = users
    }
}
