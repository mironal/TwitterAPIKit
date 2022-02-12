import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-mentions_timeline
open class GetStatusesMentionsTimelineRequestV1: TwitterAPIRequest {

    public let count: Int?
    public let maxID: String?
    public let sinceID: String?
    public let trimUser: Bool?
    public let includeEntities: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/statuses/mentions_timeline.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        count.map { p["count"] = $0 }
        maxID.map { p["max_id"] = $0 }
        sinceID.map { p["since_id"] = $0 }
        trimUser.map { p["trim_user"] = $0 }
        includeEntities.map { p["include_entities"] = $0 }
        return p
    }

    public init(
        count: Int? = .none,
        maxID: String? = .none,
        sinceID: String? = .none,
        trimUser: Bool? = .none,
        includeEntities: Bool? = .none
    ) {
        self.count = count
        self.maxID = maxID
        self.sinceID = sinceID
        self.trimUser = trimUser
        self.includeEntities = includeEntities
    }
}
