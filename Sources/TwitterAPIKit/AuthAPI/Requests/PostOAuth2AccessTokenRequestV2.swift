import Foundation

open class PostOAuth2AccessTokenRequestV2: TwitterAPIRequest {

    public let code: String
    public let grantType: String
    /// Required for Public Client.
    public let clientID: String?
    public let redirectURI: String
    public let codeVerifier: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/oauth2/token"
    }

    public var parameters: [String: Any] {
        var p = [String: String]()
        p["code"] = code
        p["grant_type"] = grantType
        clientID.map { p["client_id"] = $0 }
        p["redirect_uri"] = redirectURI
        p["code_verifier"] = codeVerifier
        return p
    }

    public init(
        code: String,
        grantType: String = "authorization_code",
        clientID: String? = .none,
        redirectURI: String,
        codeVerifier: String
    ) {
        self.code = code
        self.grantType = grantType
        self.clientID = clientID
        self.redirectURI = redirectURI
        self.codeVerifier = codeVerifier
    }
}
