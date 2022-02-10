import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-users-lookup
open class GetUsersLookupRequestV1: TwitterAPIRequest {

    public let users: TwitterUsersIdentifierV1
    public let tweetMode: Bool?
    public let includeEntities: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/users/lookup.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        users.bind(param: &p)
        tweetMode.map { p["tweet_mode"] = $0 }
        includeEntities.map { p["include_entities"] = $0 }
        return p
    }

    public init(
        users: TwitterUsersIdentifierV1,
        tweetMode: Bool? = .none,
        includeEntities: Bool? = .none
    ) {
        self.users = users
        self.tweetMode = tweetMode
        self.includeEntities = includeEntities
    }
}
