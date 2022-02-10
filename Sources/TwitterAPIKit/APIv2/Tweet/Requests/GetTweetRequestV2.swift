import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets-id
open class GetTweetRequestV2: TwitterAPIRequest {
    public let id: String
    public let expansions: Set<TwitterTweetExpansionsV2>
    public let mediaFields: Set<TwitterMediaFieldsV2>
    public let tweetFields: Set<TwitterTweetFieldsV2>
    public let userFields: Set<TwitterUserFieldsV2>
    public let pollFields: Set<TwitterPollFieldsV2>
    public let placeFields: Set<TwitterPlaceFieldsV2>

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/tweets/\(id)"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        if !expansions.isEmpty {
            p["expansions"] = expansions.commaSeparatedString
        }
        if !mediaFields.isEmpty {
            p["media.fields"] = mediaFields.commaSeparatedString
        }
        if !tweetFields.isEmpty {
            p["tweet.fields"] = tweetFields.commaSeparatedString
        }
        if !userFields.isEmpty {
            p["user.fields"] = userFields.commaSeparatedString
        }
        if !pollFields.isEmpty {
            p["poll.fields"] = pollFields.commaSeparatedString
        }
        if !placeFields.isEmpty {
            p["place.fields"] = placeFields.commaSeparatedString
        }
        return p
    }

    public init(
        id: String,
        expansions: Set<TwitterTweetExpansionsV2>? = .none,
        mediaFields: Set<TwitterMediaFieldsV2>? = .none,
        tweetFields: Set<TwitterTweetFieldsV2>? = .none,
        userFields: Set<TwitterUserFieldsV2>? = .none,
        pollFields: Set<TwitterPollFieldsV2>? = .none,
        placeFields: Set<TwitterPlaceFieldsV2>? = .none
    ) {
        self.id = id
        self.expansions = expansions ?? .init()
        self.mediaFields = mediaFields ?? .init()
        self.tweetFields = tweetFields ?? .init()
        self.userFields = userFields ?? .init()
        self.pollFields = pollFields ?? .init()
        self.placeFields = placeFields ?? .init()
    }
}
