import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-retweets-id
open class GetRetweetsRequestV1: TwitterAPIRequest {

    /// Status ID
    public let id: String
    /// max: 100
    public let count: Int?
    public let trimUser: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/statuses/retweets/\(id).json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        count.map { p["count"] = $0 }
        trimUser.map { p["trim_user"] = $0 }
        return p
    }

    public init(
        id: String,
        count: Int? = .none,
        trimUser: Bool? = .none
    ) {
        self.id = id
        self.count = count
        self.trimUser = trimUser
    }
}
