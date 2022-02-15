import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-entries-move
open class PostCollectionsEntriesMoveRequestV1: TwitterAPIRequest {

    public let id: String
    public let tweetID: String
    public let above: Bool?
    public let relativeTo: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/collections/entries/move.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["id"] = id
        p["tweet_id"] = tweetID
        above.map { p["above"] = $0 }
        p["relative_to"] = relativeTo
        return p
    }

    public init(
        id: String,
        tweetID: String,
        above: Bool? = .none,
        relativeTo: String
    ) {
        self.id = id
        self.tweetID = tweetID
        self.above = above
        self.relativeTo = relativeTo
    }
}
