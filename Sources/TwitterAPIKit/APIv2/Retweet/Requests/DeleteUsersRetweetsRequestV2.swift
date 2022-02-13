import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/delete-users-id-retweets-tweet_id
open class DeleteUsersRetweetsRequestV2: TwitterAPIRequest {

    public let id: String
    public let sourceTweetID: String

    public var method: HTTPMethod {
        return .delete
    }

    public var path: String {
        return "/2/users/\(id)/retweets/\(sourceTweetID)"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init(
        id: String,
        sourceTweetID: String
    ) {
        self.id = id
        self.sourceTweetID = sourceTweetID
    }
}
