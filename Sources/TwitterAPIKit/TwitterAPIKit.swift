import Foundation

public enum TwitterAPIAuth {
    case oauth(
        consumerKey: String,
        consumerSecret: String,
        oauthToken: String?,
        oauthTokenSecret: String?
    )
}

open class TwitterAPIKit {

    public var v1: TwitterAPIv1 { return self }
    public var v2: TwitterAPIv2 { return self }

    public let session: TwitterAPISession
    public var apiAuth: TwitterAPIAuth {
        return session.auth
    }

    public init(
        consumerKey: String, consumerSecret: String, oauthToken: String, oauthTokenSecret: String
    ) {
        session = TwitterAPISession(
            auth: .oauth(
                consumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: oauthToken,
                oauthTokenSecret: oauthTokenSecret))
    }
}
