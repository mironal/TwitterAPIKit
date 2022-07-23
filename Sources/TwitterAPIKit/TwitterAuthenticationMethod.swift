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
    /// Use the token created by "3-legged OAuth flow".
    case oauth10a(OAuth10a)

    /// Use the token created by "OAuth 2.0 Authorization Code Flow with PKCE".
    case oauth20(OAuth20)

    // Used to execute the "OAuth 2.0 Authorization Code Flow with PKCE" authentication flow.
    case requestOAuth20WithPKCE(OAuth20WithPKCEClientType)

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

        public init(clientID: String, token: TwitterOAuth2AccessToken) {
            self.init(
                clientID: clientID,
                scope: token.scope,
                tokenType: token.tokenType,
                expiresIn: token.expiresIn,
                accessToken: token.accessToken,
                refreshToken: token.refreshToken
            )
        }

        mutating public func refresh(token: TwitterOAuth2AccessToken) {
            self.scope = token.scope
            self.tokenType = token.tokenType
            self.expiresIn = token.expiresIn
            self.accessToken = token.accessToken
            self.refreshToken = token.refreshToken
        }
    }


    public enum OAuth20WithPKCEClientType {
        case confidentialClient(clientID: String, clientSecret: String)
        case publicClient

    }
}
