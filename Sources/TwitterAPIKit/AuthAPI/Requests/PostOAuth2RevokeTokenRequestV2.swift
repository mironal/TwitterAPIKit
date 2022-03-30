import Foundation

/// https://developer.twitter.com/en/docs/authentication/oauth-2-0/user-access-token
open class PostOAuth2RevokeTokenRequestV2: TwitterAPIRequest {

    public let token: String
    /// Required for Public Client.
    public let clientID: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/oauth2/revoke"
    }

    open var parameters: [String: Any] {
        var p = [String: String]()
        p["token"] = token
        clientID.map { p["client_id"] = $0 }
        return p
    }

    public init(
        token: String,
        clientID: String? = .none
    ) {
        self.token = token
        self.clientID = clientID
    }
}
