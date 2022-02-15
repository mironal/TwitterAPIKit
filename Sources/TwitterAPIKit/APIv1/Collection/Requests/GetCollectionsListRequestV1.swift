import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/get-collections-list
open class GetCollectionsListRequestV1: TwitterAPIRequest {

    public let user: TwitterUserIdentifierV1
    public let count: Int?
    public let cursor: String?
    public let tweetID: String?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/collections/list.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        user.bind(param: &p)
        count.map { p["count"] = $0 }
        cursor.map { p["cursor"] = $0 }
        tweetID.map { p["tweet_id"] = $0 }
        return p
    }

    public init(
        user: TwitterUserIdentifierV1,
        count: Int? = .none,
        cursor: String? = .none,
        tweetID: String? = .none
    ) {
        self.user = user
        self.count = count
        self.cursor = cursor
        self.tweetID = tweetID
    }
}
