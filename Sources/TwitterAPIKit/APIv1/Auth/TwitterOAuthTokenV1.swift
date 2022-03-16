import Foundation

public struct TwitterOAuthTokenV1 {
    public let oauthToken: String
    public let oauthTokenSecret: String
    public let oauthCallbackConfirmed: Bool?

    /// from:  oauth_token=zlgW3QAAAAAA2_NZAAABfxxxxxxk&oauth_token_secret=pBYEQzdbyMqIcyDzyn0X7LDxxxxxxxxx&oauth_callback_confirmed=true
    public init?(queryStringData: Data) {

        let query = String(data: queryStringData, encoding: .utf8)

        var comp = URLComponents()
        comp.query = query

        guard let oauthToken = comp.queryItems?.first(where: { $0.name == "oauth_token" })?.value,
            let oauthTokenSecret = comp.queryItems?.first(where: { $0.name == "oauth_token_secret" })?.value
        else {
            return nil
        }

        let oauthCallbackConfirmed = comp.queryItems?
            .first(where: { $0.name == "oauth_callback_confirmed" })
            .map { $0.value == "true" }

        self.oauthToken = oauthToken
        self.oauthTokenSecret = oauthTokenSecret
        self.oauthCallbackConfirmed = oauthCallbackConfirmed
    }

    public init(
        oauthToken: String,
        oauthTokenSecret: String,
        oauthCallbackConfirmed: Bool? = .none
    ) {
        self.oauthToken = oauthToken
        self.oauthTokenSecret = oauthTokenSecret
        self.oauthCallbackConfirmed = oauthCallbackConfirmed
    }
}
