import Foundation

open class TwitterAPIClient {

    public static var defaultJSONDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    public let auth: TwitterAuthAPI
    public let v1: TwitterAPIv1
    public let v2: TwitterAPIv2

    public let session: TwitterAPISession
    public var apiAuth: TwitterAuthenticationMethod {
        return session.auth
    }

    public init(
        _ auth: TwitterAuthenticationMethod,
        configuration: URLSessionConfiguration = .default,
        environment: TwitterAPIEnvironment = .init()
    ) {
        session = TwitterAPISession(
            auth: auth,
            configuration: configuration,
            environment: environment
        )
        self.auth = TwitterAuthAPIImpl(session: session)
        v1 = TwitterAPIImplV1(session: session)
        v2 = TwitterAPIImplV2(session: session)
    }

    convenience public init(
        consumerKey: String,
        consumerSecret: String,
        oauthToken: String,
        oauthTokenSecret: String
    ) {
        self.init(
            .oauth(
                consumerKey: consumerKey,
                consumerSecret: consumerSecret,
                oauthToken: oauthToken,
                oauthTokenSecret: oauthTokenSecret
            ),
            environment: .init()
        )
    }
}

extension TwitterAPIClient {

    class TwitterAuthAPIImpl {
        let session: TwitterAPISession
        init(session: TwitterAPISession) {
            self.session = session
        }
    }

    class TwitterAPIImplV1 {
        let session: TwitterAPISession
        init(session: TwitterAPISession) {
            self.session = session
        }
    }

    class TwitterAPIImplV2 {
        let session: TwitterAPISession
        init(session: TwitterAPISession) {
            self.session = session
        }
    }
}