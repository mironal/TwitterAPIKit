import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/get-lists-id-followers
open class GetListsFollowersRequestV2: TwitterAPIRequest {

    public let id: String
    public let expansions: Set<TwitterUserExpansionsV2>?
    public let maxResults: Int?
    public let paginationToken: String?
    public let tweetFields: Set<TwitterTweetFieldsV2>?
    public let userFields: Set<TwitterUserFieldsV2>?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/lists/\(id)/followers"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        expansions?.bind(param: &p)
        maxResults.map { p["max_results"] = $0 }
        paginationToken.map { p["pagination_token"] = $0 }
        tweetFields?.bind(param: &p)
        userFields?.bind(param: &p)
        return p
    }

    public init(
        id: String,
        expansions: Set<TwitterUserExpansionsV2>? = .none,
        maxResults: Int? = .none,
        paginationToken: String? = .none,
        tweetFields: Set<TwitterTweetFieldsV2>? = .none,
        userFields: Set<TwitterUserFieldsV2>? = .none
    ) {
        self.id = id
        self.expansions = expansions
        self.maxResults = maxResults
        self.paginationToken = paginationToken
        self.tweetFields = tweetFields
        self.userFields = userFields
    }
}
