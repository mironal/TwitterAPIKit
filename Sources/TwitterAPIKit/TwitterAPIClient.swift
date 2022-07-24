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

    private var refreshOAuth20TokenClient: TwitterAPIClient?
    /// Refresh OAuth2.0 token
    open func refreshOAuth20Token(
        type: TwitterAuthenticationMethod.OAuth20WithPKCEClientType,
        forceRefresh: Bool = false,
        _ block: @escaping (Result<TwitterAuthenticationMethod.OAuth20, TwitterAPIKitError>) -> Void
    ) {
        guard case .oauth20(let token) = apiAuth, let refreshToken = token.refreshToken else {
            return
        }

        if !forceRefresh, token.expired {
            block(.success(token))
            return
        }

        let refreshOAuth20TokenClient = TwitterAPIClient(.requestOAuth20WithPKCE(type))
        refreshOAuth20TokenClient.auth.oauth20.postOAuth2RefreshToken(
            .init(refreshToken: refreshToken, clientID: token.clientID)
        )
        .responseObject { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let refreshedToken):
                var token = token
                token.refresh(token: refreshedToken)
                self.session.refreshOAuth20Token(token)
                block(.success(token))
            case .failure(let error):
                block(.failure(error))
            }
            self.refreshOAuth20TokenClient = nil
        }
        self.refreshOAuth20TokenClient = refreshOAuth20TokenClient
    }
}

open class TwitterAPIBase {
    public let session: TwitterAPISession
    public init(session: TwitterAPISession) {
        self.session = session
    }
}
