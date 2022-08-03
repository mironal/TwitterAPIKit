import Foundation

open class TwitterAPISession {

    public private(set) var auth: TwitterAuthenticationMethod
    public let session: URLSession
    public let environment: TwitterAPIEnvironment
    let sessionDelegate = TwitterAPISessionDelegate()
    public init(
        auth: TwitterAuthenticationMethod,
        configuration: URLSessionConfiguration,
        environment: TwitterAPIEnvironment
    ) {
        self.auth = auth
        self.session = URLSession(configuration: configuration, delegate: sessionDelegate, delegateQueue: nil)
        self.environment = environment
    }

    deinit {
        session.invalidateAndCancel()
    }

    public func send(_ request: TwitterAPIRequest) -> TwitterAPISessionJSONTask {

        do {
            let urlRequest: URLRequest = try tryBuildURLRequest(request)
            let task = session.dataTask(with: urlRequest)
            return sessionDelegate.appendAndResume(task: task)
        } catch let error {
            return TwitterAPIFailedTask(.init(error: error))
        }
    }

    public func send(streamRequest: TwitterAPIRequest) -> TwitterAPISessionStreamTask {
        do {
            let urlRequest: URLRequest = try tryBuildURLRequest(streamRequest)
            let task = session.dataTask(with: urlRequest)
            return sessionDelegate.appendAndResumeStream(task: task)
        } catch let error {
            return TwitterAPIFailedTask(.init(error: error))
        }
    }

    private func tryBuildURLRequest(_ request: TwitterAPIRequest) throws -> URLRequest {

        var urlRequest = try request.buildRequest(environment: environment)

        switch auth {
        case let .oauth(
            consumerKey: consumerKey,
            consumerSecret: consumerSecret,
            oauthToken: oauthToken,
            oauthTokenSecret: oauthTokenSecret
        ):
            let authHeader = authorizationHeader(
                for: request.method,
                url: request.requestURL(for: environment),
                parameters: request.parameterForOAuth,
                consumerKey: consumerKey,
                consumerSecret: consumerSecret,
                oauthToken: oauthToken,
                oauthTokenSecret: oauthTokenSecret
            )
            urlRequest.setValue(authHeader, forHTTPHeaderField: "Authorization")

        case let .oauth10a(oauth10a):
            let authHeader = authorizationHeader(
                for: request.method,
                url: request.requestURL(for: environment),
                parameters: request.parameterForOAuth,
                consumerKey: oauth10a.consumerKey,
                consumerSecret: oauth10a.consumerSecret,
                oauthToken: oauth10a.oauthToken,
                oauthTokenSecret: oauth10a.oauthTokenSecret
            )
            urlRequest.setValue(authHeader, forHTTPHeaderField: "Authorization")

        case let .oauth20(oauth20):
            urlRequest.setValue("Bearer \(oauth20.accessToken)", forHTTPHeaderField: "Authorization")

        case let .requestOAuth20WithPKCE(.confidentialClient(clientID: apiKey, clientSecret: apiSecretKey)),
            let .basic(apiKey: apiKey, apiSecretKey: apiSecretKey):

            let credential = "\(apiKey):\(apiSecretKey)"
            guard let credentialData = credential.data(using: .utf8) else {
                throw TwitterAPIKitError.requestFailed(reason: .cannotEncodeStringToData(string: credential))
            }
            let credentialBase64 = credentialData.base64EncodedString(options: [])
            let basicAuth = "Basic \(credentialBase64)"
            urlRequest.setValue(basicAuth, forHTTPHeaderField: "Authorization")

        case let .bearer(token):
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        case .none, .requestOAuth20WithPKCE(.publicClient): break
        }

        return urlRequest
    }

    func refreshOAuth20Token(_ refreshedToken: TwitterAuthenticationMethod.OAuth20) {
        guard case .oauth20 = auth else {
            return
        }
        auth = .oauth20(refreshedToken)
    }
}
