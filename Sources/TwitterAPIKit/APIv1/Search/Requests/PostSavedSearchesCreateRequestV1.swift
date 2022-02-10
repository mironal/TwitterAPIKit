import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-saved_searches-create
open class PostSavedSearchesCreateRequestV1: TwitterAPIRequest {

    public let query: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/saved_searches/create.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["query"] = query
        return p
    }

    public init(
        query: String
    ) {
        self.query = query
    }
}
