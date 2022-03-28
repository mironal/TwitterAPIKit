import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/tweets/bookmarks/api-reference/post-users-id-bookmarks
open class PostUsersBookmarksRequestV2: TwitterAPIRequest {

    /// The user ID who you are bookmarking a Tweet on behalf of. It must match your own user ID or that of an authenticating user, meaning that you must pass the Access Token associated with the user ID when authenticating your request.
    public let id: String
    public let tweetID: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/users/\(id)/bookmarks"
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
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
