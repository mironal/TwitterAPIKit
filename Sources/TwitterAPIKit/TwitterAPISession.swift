import Foundation

public enum TwitterAPIKitError: Error {
    case nonHTTPResponse(Error?, Data?, URLResponse?)

    case requestError(Error, Data?, HTTPURLResponse)
}

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

    func request(
        _ method: HTTPMethod,
        path: String,
        with parameters: TwitterAPIParameters,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        var request = buildRequest(method, path: path, with: parameters)

        switch auth {
        case let .oauth(
            consumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: oauthToken,
            oauthTokenSecret: oauthTokenSecret):
            let authHeader = authorizationHeader(
                for: method,
                url: environment.baseURL.appendingPathComponent(path),
                parameters: parameters.parameters ?? [:],
                isMediaUpload: false /* TODO*/,
                consumerKey: consumerKey,
                consumerSecret: consumerSecret,
                oauthToken: oauthToken,
                oauthTokenSecret: oauthTokenSecret
            )
            request.setValue(authHeader, forHTTPHeaderField: "Authorization")
        }

        let task = session.dataTask(with: request) { data, response, error in

            guard let httpResposne = response as? HTTPURLResponse else {
                return completionHandler(.failure(.nonHTTPResponse(error, data, response)))
            }

            if let error = error {
                completionHandler(.failure(.requestError(error, data, httpResposne)))
            }

            completionHandler(.success((data ?? Data(), httpResposne)))
        }
        task.resume()

        return task
    }

    private func buildRequest(
        _ method: HTTPMethod, path: String, with parameters: TwitterAPIParameters
    ) -> URLRequest {

        var urlComponent = URLComponents(
            url: environment.baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)!

        if method.prefersQueryParameters, let parameters = parameters.parameters {
            urlComponent.queryItems = parameters.map { .init(name: $0, value: "\($1)") }
        }

        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = method.rawValue

        if !method.prefersQueryParameters,
            let parameters = parameters.parameters,
            let body = parameters.urlEncodedQueryString.data(using: .utf8)
        {
            request.httpBody = body
        }
        return request
    }
}
