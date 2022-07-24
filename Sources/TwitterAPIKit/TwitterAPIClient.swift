import Foundation

open class TwitterAPIClient {

    public static var defaultJSONDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // for v1
        let dateFormatterV1 = DateFormatter()
        dateFormatterV1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterV1.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"

        // for v2
        let dateFormatterV2 = DateFormatter()
        dateFormatterV2.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterV2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        decoder.dateDecodingStrategy = .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            if let date = dateFormatterV1.date(from: dateStr) {
                return date
            }

            if let date = dateFormatterV2.date(from: dateStr) {
                return date
            }
            throw DecodingError.dataCorrupted(
                .init(codingPath: decoder.codingPath, debugDescription: "Unexpected date format: \(dateStr)"))
        }

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

    /// for OAuth1.0a
    convenience public init(
        consumerKey: String,
        consumerSecret: String,
        oauthToken: String,
        oauthTokenSecret: String
    ) {
        self.init(
            .oauth10a(
                .init(
                    consumerKey: consumerKey,
                    consumerSecret: consumerSecret,
                    oauthToken: oauthToken,
                    oauthTokenSecret: oauthTokenSecret
                )),
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
