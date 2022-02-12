import Foundation

/// https://developer.twitter.com/en/docs/authentication/api-reference/token
open class PostOAuth2TokenRequestV1: TwitterAPIRequest {

    public let grantType: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/oauth2/token"
    }
    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["grant_type"] = grantType
        return p
    }

    public init(
        grantType: String = "client_credentials"
    ) {
        self.grantType = grantType
    }
}
