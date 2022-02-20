import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-all
open class GetTweetsCountsAllRequestV2: TwitterAPIRequest {

    public let query: String
    public let endTime: Date?
    public let granularity: TweetCountGranularityV2?
    public let nextToken: String?
    public let sinceID: String?
    public let startTime: Date?
    public let untilID: String?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/tweets/counts/all"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["query"] = query
        endTime?.bind(param: &p, for: "end_time")
        granularity?.bind(param: &p)
        nextToken.map { p["next_token"] = $0 }
        sinceID.map { p["since_id"] = $0 }
        startTime?.bind(param: &p, for: "start_time")
        untilID.map { p["until_id"] = $0 }
        return p
    }

    public init(
        query: String,
        endTime: Date? = .none,
        granularity: TweetCountGranularityV2? = .none,
        nextToken: String? = .none,
        sinceID: String? = .none,
        startTime: Date? = .none,
        untilID: String? = .none
    ) {
        self.query = query
        self.endTime = endTime
        self.granularity = granularity
        self.nextToken = nextToken
        self.sinceID = sinceID
        self.startTime = startTime
        self.untilID = untilID
    }
}
