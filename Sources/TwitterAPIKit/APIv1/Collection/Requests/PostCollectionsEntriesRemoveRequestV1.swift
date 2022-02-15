import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-entries-remove
open class PostCollectionsEntriesRemoveRequestV1: TwitterAPIRequest {

    public let id: String
    public let tweetID: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/collections/entries/remove.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["id"] = id
        p["tweet_id"] = tweetID
        return p
    }

    public init(
        id: String,
        tweetID: String
    ) {
        self.id = id
        self.tweetID = tweetID
    }
}
