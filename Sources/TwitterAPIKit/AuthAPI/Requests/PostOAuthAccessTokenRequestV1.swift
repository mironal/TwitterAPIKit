import Foundation

/// https://developer.twitter.com/en/docs/authentication/api-reference/access_token
open class PostOAuthAccessTokenRequestV1: TwitterAPIRequest {

    public let oauthToken: String
    public let oauthVerifier: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/oauth/access_token"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["oauth_token"] = oauthToken
        p["oauth_verifier"] = oauthVerifier
        return p
    }

    public init(
        oauthToken: String,
        oauthVerifier: String
    ) {
        self.oauthToken = oauthToken
        self.oauthVerifier = oauthVerifier
    }
}
