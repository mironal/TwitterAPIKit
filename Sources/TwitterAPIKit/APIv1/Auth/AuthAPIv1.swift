import Foundation

public protocol AuthAPIv1 {

    /// https://developer.twitter.com/en/docs/authentication/api-reference/request_token
    @discardableResult
    func postOAuthRequestTokenData(
        _ request: PostOAuthRequestTokenRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/authentication/api-reference/request_token
    @discardableResult
    func postOAuthRequestToken(
        _ request: PostOAuthRequestTokenRequestV1,
        completionHandler: @escaping (Result<TwitterOAuthTokenV1, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask
}

extension TwitterAPIKit: AuthAPIv1 {
    public func postOAuthRequestTokenData(
        _ request: PostOAuthRequestTokenRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func postOAuthRequestToken(
        _ request: PostOAuthRequestTokenRequestV1,
        completionHandler: @escaping (Result<TwitterOAuthTokenV1, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request) { result in
            completionHandler(
                result.flatMap {
                    guard let token = TwitterOAuthTokenV1(queryStringData: $0.data) else {
                        return .failure(
                            .responseSerializeFailed(
                                reason: .cannotConvert(data: $0.data, toTypeName: "TwitterOAuthTokenV1")))
                    }
                    return .success(token)
                }
            )
        }
    }
}
