import Foundation

/// https://developer.twitter.com/en/docs/authentication/api-reference/invalidate_access_token
open class PostOAuthInvalidateTokenRequestV1: TwitterAPIRequest {

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/oauth/invalidate_token"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init() {}
}
