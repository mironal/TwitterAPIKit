import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users
open class GetUsersRequestV2: TwitterAPIRequest {

    public let ids: [String]
    public let expansions: Set<TwitterUserExpansionsV2>?
    public let tweetFields: Set<TwitterTweetFieldsV2>?
    public let userFields: Set<TwitterUserFieldsV2>?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/users"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["ids"] = ids.joined(separator: ",")
        expansions?.bind(param: &p)
        tweetFields?.bind(param: &p)
        userFields?.bind(param: &p)
        return p
    }

    public init(
        ids: [String],
        expansions: Set<TwitterUserExpansionsV2>? = .none,
        tweetFields: Set<TwitterTweetFieldsV2>? = .none,
        userFields: Set<TwitterUserFieldsV2>? = .none
    ) {
        self.ids = ids
        self.expansions = expansions
        self.tweetFields = tweetFields
        self.userFields = userFields
    }
}
