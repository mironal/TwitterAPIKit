import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-entries-add
open class PostCollectionsEntriesAddRequestV1: TwitterAPIRequest {

    public let id: String
    public let tweetID: String
    public let above: Bool?
    public let relativeTo: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/collections/entries/add.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["id"] = id
        p["tweet_id"] = tweetID
        above.map { p["above"] = $0 }
        relativeTo.map { p["relative_to"] = $0 }
        return p
    }

    public init(
        id: String,
        tweetID: String,
        above: Bool? = .none,
        relativeTo: String? = .none
    ) {
        self.id = id
        self.tweetID = tweetID
        self.above = above
        self.relativeTo = relativeTo
    }
}
