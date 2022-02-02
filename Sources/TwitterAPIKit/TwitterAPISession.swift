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

    func send(
        _ request: TwitterAPIRequest,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        var urlRequest = request.buildRequest(environment: environment)

        switch auth {
        case let .oauth(
            consumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: oauthToken,
            oauthTokenSecret: oauthTokenSecret):
            let authHeader = authorizationHeader(
                for: request.method,
                url: environment.baseURL.appendingPathComponent(request.path),
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

}

extension TwitterAPIRequest {
    func buildRequest(environment: TwitterAPIEnvironment) -> URLRequest {

        var urlComponent = URLComponents(
            url: environment.baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)!

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
