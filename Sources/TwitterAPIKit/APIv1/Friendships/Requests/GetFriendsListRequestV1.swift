import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friends-list
open class GetFriendsListRequestV1: TwitterAPIRequest {

    public let user: TwitterUserIdentifierV1
    public let count: Int?
    public let cursor: String?
    public let skipStatus: Bool?
    public let includeUserEntities: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/friends/list.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        user.bind(param: &p)
        count.map { p["count"] = $0 }
        cursor.map { p["cursor"] = $0 }
        skipStatus.map { p["skip_status"] = $0 }
        includeUserEntities.map { p["include_user_entities"] = $0 }
        return p
    }

    public init(
        user: TwitterUserIdentifierV1,
        count: Int? = .none,
        cursor: String? = .none,
        skipStatus: Bool? = .none,
        includeUserEntities: Bool? = .none
    ) {
        self.user = user
        self.count = count
        self.cursor = cursor
        self.skipStatus = skipStatus
        self.includeUserEntities = includeUserEntities
    }
}
