import Foundation

public struct TwitterOAuthAccessTokenV1 {

    public let oauthToken: String
    public let oauthTokenSecret: String

    // According to RFC5849, there is no mention of the user_id and screen_name parameters, but TwitterAPI does include them in its response.

    public let userID: String?
    public let screenName: String?

    /// From:
    /// oauth_token=your_oauth_token
    /// &oauth_token_secret=your_oauth_token_secret
    /// &user_id=numeric_user_id
    /// &screen_name=your_screen_name
    public init?(queryStringData: Data) {
        let query = String(data: queryStringData, encoding: .utf8)

        var comp = URLComponents()
        comp.query = query
        guard let oauthToken = comp.queryItems?.first(where: { $0.name == "oauth_token" })?.value,
            let oauthTokenSecret = comp.queryItems?.first(where: { $0.name == "oauth_token_secret" })?.value
        else {
            return nil
        }

        self.oauthToken = oauthToken
        self.oauthTokenSecret = oauthTokenSecret
        self.userID = comp.queryItems?.first(where: { $0.name == "user_id" })?.value
        self.screenName = comp.queryItems?.first(where: { $0.name == "screen_name" })?.value
    }

    public init(
        oauthToken: String,
        oauthTokenSecret: String,
        userID: String? = .none,
        screenName: String? = .none
    ) {
        self.oauthToken = oauthToken
        self.oauthTokenSecret = oauthTokenSecret
        self.userID = userID
        self.screenName = screenName
    }

}
