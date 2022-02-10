import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-saved_searches-destroy-id
open class PostSavedSearchesDestroyRequestV1: TwitterAPIRequest {

    public let id: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/saved_searches/destroy/\(id).json"
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
