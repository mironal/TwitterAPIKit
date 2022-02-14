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

    /// Create https://developer.twitter.com/en/docs/authentication/api-reference/authorize URL.
    func makeOAuthAuthorizeURL(_ request: GetOAuthAuthorizeRequestV1) -> URL?

    /// Create https://developer.twitter.com/en/docs/authentication/api-reference/authenticate URL.
    func makeOAuthAuthenticateURL(_ request: GetOAuthAuthenticateRequestV1) -> URL?

    /// https://developer.twitter.com/en/docs/authentication/api-reference/access_token
    @discardableResult
    func postOAuthAccessTokenData(
        _ request: PostOAuthAccessTokenRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/authentication/api-reference/access_token
    @discardableResult
    func postOAuthAccessToken(
        _ request: PostOAuthAccessTokenRequestV1,
        completionHandler: @escaping (Result<TwitterOAuthAccessTokenV1, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/authentication/api-reference/invalidate_access_token
    @discardableResult
    func postInvalidateAccessToken(
        _ request: PostOAuthInvalidateTokenRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/authentication/api-reference/token
    @discardableResult
    func postOAuth2BearerTokenData(
        _ request: PostOAuth2TokenRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/authentication/api-reference/token
    @discardableResult
    func postOAuth2BearerToken(
        _ request: PostOAuth2TokenRequestV1,
        completionHandler: @escaping (Result<TwitterOAuth2BearerToken, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/authentication/api-reference/invalidate_bearer_token
    ///
    ///May not work. {"errors":[{"code":348,"message":"Client application is not permitted to to invalidate this token."}]}
    /// https://twittercommunity.com/t/oauth2-invalidate-token-not-working-for-app-only-authentication-tokens/133108
    /// https://twittercommunity.com/t/invalidate-bearer-client-application-not-permitted/162761
    @discardableResult
    func postInvalidateOAuth2BearerToken(
        _ request: PostOAuth2InvalidateTokenRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask
}

extension TwitterAPIKit.TwitterAPIImpl: AuthAPIv1 {
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
                                reason: .cannotConvert(data: $0.data, toTypeName: "TwitterOAuthTokenV1")
                            )
                        )
                    }
                    return .success(token)
                }
            )
        }
    }

    public func makeOAuthAuthorizeURL(_ request: GetOAuthAuthorizeRequestV1) -> URL? {
        // ignore exception
        return try? request.buildRequest(environment: session.environment).url
    }

    public func makeOAuthAuthenticateURL(_ request: GetOAuthAuthenticateRequestV1) -> URL? {
        // ignore exception
        return try? request.buildRequest(environment: session.environment).url
    }

    public func postOAuthAccessTokenData(
        _ request: PostOAuthAccessTokenRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func postOAuthAccessToken(
        _ request: PostOAuthAccessTokenRequestV1,
        completionHandler: @escaping (Result<TwitterOAuthAccessTokenV1, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request) { result in
            completionHandler(
                result.flatMap {
                    guard let token = TwitterOAuthAccessTokenV1(queryStringData: $0.data) else {
                        return .failure(
                            .responseSerializeFailed(
                                reason: .cannotConvert(data: $0.data, toTypeName: "TwitterOAuthAccessTokenV1")
                            )
                        )
                    }
                    return .success(token)
                }
            )
        }
    }

    public func postInvalidateAccessToken(
        _ request: PostOAuthInvalidateTokenRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func postOAuth2BearerTokenData(
        _ request: PostOAuth2TokenRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func postOAuth2BearerToken(
        _ request: PostOAuth2TokenRequestV1,
        completionHandler: @escaping (Result<TwitterOAuth2BearerToken, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request) { result in
            completionHandler(
                result.flatMap {
                    do {
                        guard let token = try TwitterOAuth2BearerToken(jsonData: $0.data) else {
                            return .failure(
                                .responseSerializeFailed(
                                    reason: .cannotConvert(data: $0.data, toTypeName: "TwitterOAuth2BearerToken")
                                )
                            )
                        }
                        return .success(token)
                    } catch let error {
                        return .failure(
                            .responseSerializeFailed(
                                reason: .jsonSerializationFailed(error: error, data: $0.data, rateLimit: $0.rateLimit)
                            )
                        )
                    }
                }
            )
        }
    }

    public func postInvalidateOAuth2BearerToken(
        _ request: PostOAuth2InvalidateTokenRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }
}
