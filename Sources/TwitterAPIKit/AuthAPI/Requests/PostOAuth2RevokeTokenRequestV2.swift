import Foundation

/// https://developer.twitter.com/en/docs/authentication/oauth-2-0/user-access-token
open class PostOAuth2RevokeTokenRequestV2: TwitterAPIRequest {

    public let token: String
    /// Required for Public Client.
    public let clientID: String?
    /// Maybe need this parameter when you got {"error":"invalid_request","error_description":"Missing required parameter [token_type_hint]."}
    /// access_token or refresh_token
    /// > https://datatracker.ietf.org/doc/html/rfc7009#section-2.1
    public let tokenTypeHint: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/oauth2/revoke"
    }

    open var parameters: [String: Any] {
        var p = [String: String]()
        p["token"] = token
        tokenTypeHint.map { p["token_type_hint"] = $0 }
        clientID.map { p["client_id"] = $0 }

        return p
    }

    public init(
        token: String,
        clientID: String? = .none,
        tokenTypeHint: String? = .none
    ) {
        self.token = token
        self.clientID = clientID
        self.tokenTypeHint = tokenTypeHint
    }
}
