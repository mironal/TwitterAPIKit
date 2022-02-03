import Foundation

public class GetTimelineRequestV1: TwitterAPIRequest {

    public let count: Int?
    public let sinceID: String?
    public let maxID: String?
    public let trimUser: Bool?
    public let excludeReplies: Bool?
    public let includeEntities: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        fatalError("Not impl")
    }

    public var parameters: [String: Any]? {
        var p = [String: Any]()
        count.map { p["count"] = $0 }
        sinceID.map { p["since_id"] = $0 }
        maxID.map { p["max_id"] = $0 }
        trimUser.map { p["trim_user"] = $0 }
        excludeReplies.map { p["exclude_replies"] = $0 }
        includeEntities.map { p["include_entities"] = $0 }
        return p
    }

    public init(
        count: Int? = nil,
        sinceID: String? = nil,
        maxID: String? = nil,
        trimUser: Bool? = nil,
        excludeReplies: Bool? = nil,
        includeEntities: Bool? = nil
    ) {
        self.count = count
        self.sinceID = sinceID
        self.maxID = maxID
        self.trimUser = trimUser
        self.excludeReplies = excludeReplies
        self.includeEntities = includeEntities
    }
}

public class GetHomeTimelineRequestV1: GetTimelineRequestV1 {
    public override var path: String {
        return "/1.1/statuses/home_timeline.json"
    }
}

public class GetMentionsTimelineRequestV1: GetTimelineRequestV1 {
    public override var path: String {
        return "/1.1/statuses/mentions_timeline.json"
    }
}
