import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-tweets
open class GetSpacesTweetsRequestV2: TwitterAPIRequest {

    public let id: String
    public let expansions: Set<TwitterTweetExpansionsV2>?
    public let mediaFields: Set<TwitterMediaFieldsV2>?
    public let placeFields: Set<TwitterPlaceFieldsV2>?
    public let pollFields: Set<TwitterPollFieldsV2>?
    public let tweetFields: Set<TwitterTweetFieldsV2>?
    public let userFields: Set<TwitterUserFieldsV2>?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/spaces/\(id)/tweets"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        expansions?.bind(param: &p)
        mediaFields?.bind(param: &p)
        placeFields?.bind(param: &p)
        pollFields?.bind(param: &p)
        tweetFields?.bind(param: &p)
        userFields?.bind(param: &p)
        return p
    }

    public init(
        id: String,
        expansions: Set<TwitterTweetExpansionsV2>? = .none,
        mediaFields: Set<TwitterMediaFieldsV2>? = .none,
        placeFields: Set<TwitterPlaceFieldsV2>? = .none,
        pollFields: Set<TwitterPollFieldsV2>? = .none,
        tweetFields: Set<TwitterTweetFieldsV2>? = .none,
        userFields: Set<TwitterUserFieldsV2>? = .none
    ) {
        self.id = id
        self.expansions = expansions
        self.mediaFields = mediaFields
        self.placeFields = placeFields
        self.pollFields = pollFields
        self.tweetFields = tweetFields
        self.userFields = userFields
    }
}
