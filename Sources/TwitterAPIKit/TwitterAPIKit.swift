import Foundation

public enum TwitterAPIAuth {
    case oauth(
        consumerKey: String,
        consumerSecret: String,
        oauthToken: String?,
        oauthTokenSecret: String?
    )
}

public struct TwitterAPIEnvironment {
    let baseURL: URL

    public init(url: URL = URL(string: "https://api.twitter.com")!) {
        baseURL = url
    }
}

open class TwitterAPIKit {

    public var v1: TweetAPIv1 & TimelineAPIv1 { return self }
    public var v2: TwitterAPIv2 { return self }

    public let session: TwitterAPISession
    public var apiAuth: TwitterAPIAuth {
        return session.auth
    }

    public init(
        consumerKey: String,
        consumerSecret: String,
        oauthToken: String,
        oauthTokenSecret: String,
        environment: TwitterAPIEnvironment = .init()
    ) {
        session = TwitterAPISession(
            auth: .oauth(
                consumerKey: consumerKey,
                consumerSecret: consumerSecret,
                oauthToken: oauthToken,
                oauthTokenSecret: oauthTokenSecret),
            environment: environment
        )
    }
}
