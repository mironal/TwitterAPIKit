import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-users-id-liked_tweets
open class GetUsersLikedTweetsRequestV2: TwitterAPIRequest {

    /// User ID
    public let id: String
    public let expansions: Set<TwitterTweetExpansionsV2>?
    public let maxResults: Int?
    public let mediaFields: Set<TwitterMediaFieldsV2>?
    public let paginationToken: String?
    public let placeFields: Set<TwitterPlaceFieldsV2>?
    public let pollFields: Set<TwitterPollFieldsV2>?
    public let tweetFields: Set<TwitterTweetFieldsV2>?
    public let userFields: Set<TwitterUserFieldsV2>?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/users/\(id)/liked_tweets"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        expansions?.bind(param: &p)
        maxResults.map { p["max_results"] = $0 }
        mediaFields?.bind(param: &p)
        paginationToken.map { p["pagination_token"] = $0 }
        placeFields?.bind(param: &p)
        pollFields?.bind(param: &p)
        tweetFields?.bind(param: &p)
        userFields?.bind(param: &p)
        return p
    }

    public init(
        id: String,
        expansions: Set<TwitterTweetExpansionsV2>? = .none,
        maxResults: Int? = .none,
        mediaFields: Set<TwitterMediaFieldsV2>? = .none,
        paginationToken: String? = .none,
        placeFields: Set<TwitterPlaceFieldsV2>? = .none,
        pollFields: Set<TwitterPollFieldsV2>? = .none,
        tweetFields: Set<TwitterTweetFieldsV2>? = .none,
        userFields: Set<TwitterUserFieldsV2>? = .none
    ) {
        self.id = id
        self.expansions = expansions
        self.maxResults = maxResults
        self.mediaFields = mediaFields
        self.paginationToken = paginationToken
        self.placeFields = placeFields
        self.pollFields = pollFields
        self.tweetFields = tweetFields
        self.userFields = userFields
    }
}
