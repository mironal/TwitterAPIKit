import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-retweets_of_me
open class GetRetweetsOfMeRequestV1: TwitterAPIRequest {

    public let count: Int?
    public let sinceID: String?
    public let maxID: String?
    public let trimUser: Bool?
    public let includeEntities: Bool?
    public let includeUserEntities: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/statuses/retweets_of_me.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()

        count.map { p["count"] = $0 }
        sinceID.map { p["since_id"] = $0 }
        maxID.map { p["max_id"] = $0 }
        trimUser.map { p["trim_user"] = $0 }
        includeEntities.map { p["include_entities"] = $0 }
        includeUserEntities.map { p["include_user_entities"] = $0 }

        return p
    }

    public init(
        count: Int? = .none,
        sinceID: String? = .none,
        maxID: String? = .none,
        trimUser: Bool? = .none,
        includeEntities: Bool? = .none,
        includeUserEntities: Bool? = .none
    ) {
        self.count = count
        self.sinceID = sinceID
        self.maxID = maxID
        self.trimUser = trimUser
        self.includeEntities = includeEntities
        self.includeUserEntities = includeUserEntities
    }

}
