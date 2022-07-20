import Foundation

public enum TwitterAuthenticationMethod {
    case none

    @available(*, deprecated, renamed: "oauth10a")
    case oauth(
        consumerKey: String,
        consumerSecret: String,
        oauthToken: String?,
        oauthTokenSecret: String?
    )

    case oauth10a(OAuth10a)

    /// For OAuth 2.0 Authorization Code Flow with PKCE.
    case oauth20(OAuth20)

    case basic(apiKey: String, apiSecretKey: String)

    /// For OAuth2 app-only
    case bearer(String)
}

extension TwitterAuthenticationMethod {

    public struct OAuth10a: Codable {
        public var consumerKey: String
        public var consumerSecret: String
        public var oauthToken: String?
        public var oauthTokenSecret: String?

        public init(
            consumerKey: String,
            consumerSecret: String,
            oauthToken: String?,
            oauthTokenSecret: String?
        ) {
            self.consumerKey = consumerKey
            self.consumerSecret = consumerSecret
            self.oauthToken = oauthToken
            self.oauthTokenSecret = oauthTokenSecret
        }
    }

    public struct OAuth20: Codable {
        public var clientID: String
        public var scope: [String]
        public var tokenType: String
        public var expiresIn: Int
        public var accessToken: String

        /// Only Public Client
        public var refreshToken: String?

        public init(
            clientID: String,
            scope: [String],
            tokenType: String,
            expiresIn: Int,
            accessToken: String,
            refreshToken: String?
        ) {
            self.clientID = clientID
            self.scope = scope
            self.tokenType = tokenType
            self.expiresIn = expiresIn
            self.accessToken = accessToken
            self.refreshToken = refreshToken
        }
    }
}
