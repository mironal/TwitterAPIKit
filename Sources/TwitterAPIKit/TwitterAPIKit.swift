import Foundation

public enum TwitterAuthenticationMethod {
    case none
    case oauth(
        consumerKey: String,
        consumerSecret: String,
        oauthToken: String?,
        oauthTokenSecret: String?
    )

    case basic(apiKey: String, apiSecretKey: String)

    case bearer(String)
}

public enum TwitterBaseURLType {
    case twitter
    case api
    case upload
}

public struct TwitterAPIEnvironment {
    let twitterURL: URL
    let apiURL: URL
    let uploadURL: URL

    public init(
        twitterURL: URL = URL(string: "https://twitter.com")!,
        apiURL: URL = URL(string: "https://api.twitter.com")!,
        uploadURL: URL = URL(string: "https://upload.twitter.com")!
    ) {
        self.twitterURL = twitterURL
        self.apiURL = apiURL
        self.uploadURL = uploadURL
    }
}
