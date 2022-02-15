import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-entries-curate
open class PostCollectionsEntriesCurateRequestV1: TwitterAPIRequest {

    public enum Operation {
        case add(tweetID: String)
        case remove(tweetID: String)

        var keyValue: [String: String] {
            switch self {
            case .add(let tweetID):
                return ["op": "add", "tweet_id": tweetID]
            case .remove(let tweetID):
                return ["op": "remove", "tweet_id": tweetID]
            }
        }
    }

    public let id: String
    public let changes: [Operation]

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/collections/entries/curate.json"
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["id"] = id
        p["changes"] = changes.map { $0.keyValue }
        return p
    }

    public init(
        id: String,
        changes: [Operation]
    ) {
        self.id = id
        self.changes = changes
    }
}
