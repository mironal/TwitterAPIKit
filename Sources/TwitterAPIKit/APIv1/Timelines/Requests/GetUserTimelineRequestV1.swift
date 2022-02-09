import Foundation

open class GetUserTimelineRequestV1: TwitterAPIRequest {

    public let target: TwitterUserIdentifierV1
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
        target.bind(param: &p)
        count.map { p["count"] = $0 }
        sinceID.map { p["since_id"] = $0 }
        maxID.map { p["max_id"] = $0 }
        trimUser.map { p["trim_user"] = $0 }
        excludeReplies.map { p["exclude_replies"] = $0 }
        includeRTs.map { p["include_rts"] = $0 }
        return p
    }

    public init(
        target: TwitterUserIdentifierV1,
        count: Int? = .none,
        sinceID: String? = .none,
        maxID: String? = .none,
        trimUser: Bool? = .none,
        excludeReplies: Bool? = .none,
        includeRTs: Bool? = .none
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
