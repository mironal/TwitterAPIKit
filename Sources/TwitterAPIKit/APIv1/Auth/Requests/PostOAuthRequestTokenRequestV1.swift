import Foundation

/// https://developer.twitter.com/en/docs/authentication/api-reference/request_token
open class PostOAuthRequestTokenRequestV1: TwitterAPIRequest {

    /// If you are using pin-based authorization, you will need to set this to oob
    public let oauthCallback: String

    /// read or write
    public let xAuthAccessType: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/oauth/request_token"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["oauth_callback"] = oauthCallback
        xAuthAccessType.map { p["x_auth_access_type"] = $0 }
        return p
    }

    public init(
        oauthCallback: String,
        xAuthAccessType: String? = .none
    ) {
        self.oauthCallback = oauthCallback
        self.xAuthAccessType = xAuthAccessType
    }
}
