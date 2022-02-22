import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-recent
open class GetTweetsSearchRecentRequestV2: TwitterAPIRequest {

    public enum TwitterSearchTweetsSortOrderV2: String {
        case recency
        case relevancy

        func bind(param: inout [String: Any]) {
            param["sort_order"] = rawValue
        }
    }

    public let query: String
    public let endTime: Date?
    public let expansions: Set<TwitterTweetExpansionsV2>?
    public let maxResults: Int?
    public let mediaFields: Set<TwitterMediaFieldsV2>?
    public let nextToken: String?
    public let placeFields: Set<TwitterPlaceFieldsV2>?
    public let pollFields: Set<TwitterPollFieldsV2>?
    public let sinceID: String?
    public let sortOrder: TwitterSearchTweetsSortOrderV2?
    public let startTime: Date?
    public let tweetFields: Set<TwitterTweetFieldsV2>?
    public let untilID: String?
    public let userFields: Set<TwitterUserFieldsV2>?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/tweets/search/recent"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["query"] = query
        endTime?.bind(param: &p, for: "end_time")
        expansions?.bind(param: &p)
        maxResults.map { p["max_results"] = $0 }
        mediaFields?.bind(param: &p)
        nextToken.map { p["next_token"] = $0 }
        placeFields?.bind(param: &p)
        pollFields?.bind(param: &p)
        sinceID.map { p["since_id"] = $0 }
        sortOrder?.bind(param: &p)
        startTime?.bind(param: &p, for: "start_time")
        tweetFields?.bind(param: &p)
        untilID.map { p["until_id"] = $0 }
        userFields?.bind(param: &p)
        return p
    }

    public init(
        query: String,
        endTime: Date? = .none,
        expansions: Set<TwitterTweetExpansionsV2>? = .none,
        maxResults: Int? = .none,
        mediaFields: Set<TwitterMediaFieldsV2>? = .none,
        nextToken: String? = .none,
        placeFields: Set<TwitterPlaceFieldsV2>? = .none,
        pollFields: Set<TwitterPollFieldsV2>? = .none,
        sinceID: String? = .none,
        sortOrder: TwitterSearchTweetsSortOrderV2? = .none,
        startTime: Date? = .none,
        tweetFields: Set<TwitterTweetFieldsV2>? = .none,
        untilID: String? = .none,
        userFields: Set<TwitterUserFieldsV2>? = .none
    ) {
        self.query = query
        self.endTime = endTime
        self.expansions = expansions
        self.maxResults = maxResults
        self.mediaFields = mediaFields
        self.nextToken = nextToken
        self.placeFields = placeFields
        self.pollFields = pollFields
        self.sinceID = sinceID
        self.sortOrder = sortOrder
        self.startTime = startTime
        self.tweetFields = tweetFields
        self.untilID = untilID
        self.userFields = userFields
    }
}
