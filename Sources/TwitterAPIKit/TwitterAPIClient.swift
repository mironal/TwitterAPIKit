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
        self.auth = TwitterAuthAPI(session: session)
        v1 = TwitterAPIv1(session: session)
        v2 = TwitterAPIv2(session: session)
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

open class TwitterAPIBase {
    public let session: TwitterAPISession
    public init(session: TwitterAPISession) {
        self.session = session
    }
}

extension TwitterAPIClient {

    class TwitterAPIImplV2 {
        let session: TwitterAPISession
        init(session: TwitterAPISession) {
            self.session = session
        }
    }
}
