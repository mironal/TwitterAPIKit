import Foundation

public enum TwitterAPIKitError: Error {
    case nonHTTPResponse(Error?, Data?, URLResponse?)

    case requestError(Error, Data?, HTTPURLResponse)
}

open class TwitterAPISession {

    public let auth: TwitterAPIAuth
    public let session: URLSession

    public init(auth: TwitterAPIAuth, session: URLSession = .shared) {
        self.auth = auth
        self.session = session
    }

    func request(
        _ parameter: TwitterAPIParameter,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        var request = parameter.buildRequest()

        switch auth {
        case let .oauth(
            consumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: oauthToken,
            oauthTokenSecret: oauthTokenSecret):
            let authHeader = authorizationHeader(
                for: parameter.method,
                url: parameter.urlWituoutQuery,
                parameters: parameter.parameters ?? [:],
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
}

extension TwitterAPIParameter {
    fileprivate func buildRequest() -> URLRequest {

        var urlComponent = URLComponents(
            url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)!

        if method.prefersQueryParameters, let parameters = parameters {
            urlComponent.queryItems = parameters.map { .init(name: $0, value: "\($1)") }
        }

        var request = URLRequest(url: urlComponent.url!)

        if !method.prefersQueryParameters, let parameters = parameters {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let body = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = body
        }
        return request
    }

    fileprivate var urlWituoutQuery: URL {
        return baseURL.appendingPathComponent(path)
    }
}
