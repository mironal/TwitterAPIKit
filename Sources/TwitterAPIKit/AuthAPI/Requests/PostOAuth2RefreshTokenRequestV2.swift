import Foundation

/// https://developer.twitter.com/en/docs/authentication/oauth-2-0/user-access-token
open class PostOAuth2RefreshTokenRequestV2: TwitterAPIRequest {

    public let refreshToken: String
    public let grantType: String
    /// Required for Public Client.
    public let clientID: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/oauth2/token"
    }

    public var parameters: [String: Any] {
        var p = [String: String]()

        p["refresh_token"] = refreshToken
        p["grant_type"] = grantType
        clientID.map { p["client_id"] = $0 }

        return p
    }

    public init(
        refreshToken: String,
        grantType: String = "refresh_token",
        clientID: String? = .none
    ) {
        self.refreshToken = refreshToken
        self.grantType = grantType
        self.clientID = clientID
    }
}
