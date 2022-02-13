import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/delete-users-id-likes-tweet_id
open class DeleteUsersLikesRequestV2: TwitterAPIRequest {

    /// user ID
    public let id: String
    public let tweetID: String

    public var method: HTTPMethod {
        return .delete
    }

    public var path: String {
        return "/2/users/\(id)/likes/\(tweetID)"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init(
        id: String,
        tweetID: String
    ) {
        self.id = id
        self.tweetID = tweetID
    }
}
