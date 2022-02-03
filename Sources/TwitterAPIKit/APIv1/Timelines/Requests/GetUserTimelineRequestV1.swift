import Foundation

open class GetUserTimelineRequestV1: TwitterAPIRequest {
    public enum Target {
        case userID(String)
        case screenName(String)
    }

    public let target: Target  // user_id or screen_name
    public let count: Int?
    public let sinceID: String?
    public let maxID: String?
    public let trimUser: Bool?
    public let excludeReplies: Bool?
    public let includeRTs: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/statuses/user_timeline.json"
    }

    open var parameters: [String: Any]? {
        var p = [String: Any]()

        switch target {
        case .userID(let string):
            p["user_id"] = string
        case .screenName(let string):
            p["screen_name"] = string
        }
        count.map { p["count"] = $0 }
        sinceID.map { p["since_id"] = $0 }
        maxID.map { p["max_id"] = $0 }
        trimUser.map { p["trim_user"] = $0 }
        excludeReplies.map { p["exclude_replies"] = $0 }
        includeRTs.map { p["include_rts"] = $0 }
        return p
    }

    public init(
        target: Target,
        count: Int? = nil,
        sinceID: String? = nil,
        maxID: String? = nil,
        trimUser: Bool? = nil,
        excludeReplies: Bool? = nil,
        includeRTs: Bool? = nil
    ) {
        self.target = target
        self.count = count
        self.sinceID = sinceID
        self.maxID = maxID
        self.trimUser = trimUser
        self.excludeReplies = excludeReplies
        self.includeRTs = includeRTs
    }
}
