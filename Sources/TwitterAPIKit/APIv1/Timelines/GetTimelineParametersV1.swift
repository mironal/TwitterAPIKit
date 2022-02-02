import Foundation

public struct GetTimelineParametersV1: TwitterAPIParameters {

    public let count: Int?
    public let sinceID: String?
    public let maxID: String?
    public let trimUser: Bool?
    public let excludeReplies: Bool?
    public let includeEntities: Bool?

    var parameters: [String: Any]? {
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
