import Foundation

/// https://developer.twitter.com/en/docs/authentication/api-reference/authorize
open class GetOAuthAuthorizeRequestV1: TwitterAPIRequest {

    public let oauthToken: String?
    public let forceLogin: Bool?
    public let screenName: String?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/oauth/authorize"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        oauthToken.map { p["oauth_token"] = $0 }
        forceLogin.map { p["force_login"] = $0 }
        screenName.map { p["screen_name"] = $0 }
        return p
    }

    public init(
        oauthToken: String? = .none,
        forceLogin: Bool? = .none,
        screenName: String? = .none
    ) {
        self.oauthToken = oauthToken
        self.forceLogin = forceLogin
        self.screenName = screenName
    }
}
