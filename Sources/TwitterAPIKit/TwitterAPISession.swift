import Foundation

public enum TwitterAPIKitError: Error {
    case connectionError(Error?, Data?, URLResponse?)

    case requestError(Error, Data?, TwitterRateLimit, HTTPURLResponse)

    case unacceptableStatusCode(code: Int, Data?, TwitterRateLimit, HTTPURLResponse)

    public var data: Data? {
        switch self {
        case .connectionError(_, let data, _),
            .requestError(_, let data, _, _),
            .unacceptableStatusCode(code: _, let data, _, _):
            return data
        }
    }

    public var rateLimit: TwitterRateLimit? {
        switch self {
        case .connectionError:
            return nil
        case .requestError(_, _, let rateLimit, _),
            .unacceptableStatusCode(code: _, _, let rateLimit, _):
            return rateLimit
        }
    }
}

public typealias TwitterAPISuccessReponse = (Data, TwitterRateLimit, HTTPURLResponse)

open class TwitterAPISession {

    public let auth: TwitterAPIAuth
    public let session: URLSession
    public let environment: TwitterAPIEnvironment

    public init(
        auth: TwitterAPIAuth, session: URLSession = .shared, environment: TwitterAPIEnvironment
    ) {
        self.auth = auth
        self.session = session
        self.environment = environment
    }

    public func send(
        _ request: TwitterAPIRequest,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        var urlRequest = request.buildRequest(environment: environment)

        switch auth {
        case let .oauth(
            consumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: oauthToken,
            oauthTokenSecret: oauthTokenSecret):
            let authHeader = authorizationHeader(
                for: request.method,
                url: request.requestURL(for: environment),
                parameters: request.parameters ?? [:],
                isMediaUpload: false /* TODO*/,
                consumerKey: consumerKey,
                consumerSecret: consumerSecret,
                oauthToken: oauthToken,
                oauthTokenSecret: oauthTokenSecret
            )
            urlRequest.setValue(authHeader, forHTTPHeaderField: "Authorization")
        }

        let task = session.dataTask(with: urlRequest) { data, response, error in
            // May be "Error Domain=NSURLErrorDomain Code=-1009 The Internet connection appears to be offline."
            guard let httpResposne = response as? HTTPURLResponse else {
                return completionHandler(.failure(.connectionError(error, data, response)))
            }

            let rateLimit = TwitterRateLimit(header: httpResposne.allHeaderFields)

            if let error = error {
                completionHandler(.failure(.requestError(error, data, rateLimit, httpResposne)))
            }

            guard 200..<300 ~= httpResposne.statusCode else {
                completionHandler(
                    .failure(
                        .unacceptableStatusCode(
                            code: httpResposne.statusCode, data, rateLimit, httpResposne)
                    )
                )
                return
            }

            completionHandler(.success((data ?? Data(), rateLimit, httpResposne)))
        }
        task.resume()

        return task
    }
}

extension TwitterAPIRequest {

    func requestURL(for environment: TwitterAPIEnvironment) -> URL {
        return environment.baseURL(for: baseURLType).appendingPathComponent(path)
    }

    func buildRequest(environment: TwitterAPIEnvironment) -> URLRequest {

        var urlComponent = URLComponents(
            url: requestURL(for: environment),
            resolvingAgainstBaseURL: true
        )!
        if method.prefersQueryParameters, let parameters = parameters {
            urlComponent.queryItems = parameters.map { .init(name: $0, value: "\($1)") }
        }

        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = method.rawValue

        if !method.prefersQueryParameters,
            let parameters = parameters,
            let body = parameters.urlEncodedQueryString.data(using: .utf8)
        {
            request.httpBody = body
        }
        return request
    }
}

extension TwitterAPIEnvironment {
    func baseURL(for type: TwitterBaseURLType) -> URL {
        switch type {
        case .api: return apiURL
        case .upload: return uploadURL
        }
    }
}
