import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/delete-tweets-id
open class DeleteTweetRequestV2: TwitterAPIRequest {

    public let id: String

    public var method: HTTPMethod {
        return .delete
    }

    public var path: String {
        return "/2/tweets/\(id)"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init(
        id: String
    ) {
        self.id = id
    }
}
