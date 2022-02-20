import Foundation

public protocol AuthAPIv1 {

    /// https://developer.twitter.com/en/docs/authentication/api-reference/request_token
    func postOAuthRequestTokenData(
        _ request: PostOAuthRequestTokenRequestV1
    ) -> TwitterAPISessionDataTask

    /// https://developer.twitter.com/en/docs/authentication/api-reference/request_token
    func postOAuthRequestToken(
        _ request: PostOAuthRequestTokenRequestV1
    ) -> TwitterAPISessionSpecializedTask<TwitterOAuthTokenV1>

    /// Create https://developer.twitter.com/en/docs/authentication/api-reference/authorize URL.
    func makeOAuthAuthorizeURL(_ request: GetOAuthAuthorizeRequestV1) -> URL?

    /// Create https://developer.twitter.com/en/docs/authentication/api-reference/authenticate URL.
    func makeOAuthAuthenticateURL(_ request: GetOAuthAuthenticateRequestV1) -> URL?

    /// https://developer.twitter.com/en/docs/authentication/api-reference/access_token
    func postOAuthAccessTokenData(
        _ request: PostOAuthAccessTokenRequestV1
    ) -> TwitterAPISessionDataTask

    /// https://developer.twitter.com/en/docs/authentication/api-reference/access_token
    func postOAuthAccessToken(
        _ request: PostOAuthAccessTokenRequestV1
    ) -> TwitterAPISessionSpecializedTask<TwitterOAuthAccessTokenV1>

    /// https://developer.twitter.com/en/docs/authentication/api-reference/invalidate_access_token
    func postInvalidateAccessToken(
        _ request: PostOAuthInvalidateTokenRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/authentication/api-reference/token
    func postOAuth2BearerTokenData(
        _ request: PostOAuth2TokenRequestV1
    ) -> TwitterAPISessionDataTask

    /// https://developer.twitter.com/en/docs/authentication/api-reference/token
    func postOAuth2BearerToken(
        _ request: PostOAuth2TokenRequestV1
    ) -> TwitterAPISessionSpecializedTask<TwitterOAuth2BearerToken>

    /// https://developer.twitter.com/en/docs/authentication/api-reference/invalidate_bearer_token
    ///
    ///May not work. {"errors":[{"code":348,"message":"Client application is not permitted to to invalidate this token."}]}
    /// https://twittercommunity.com/t/oauth2-invalidate-token-not-working-for-app-only-authentication-tokens/133108
    /// https://twittercommunity.com/t/invalidate-bearer-client-application-not-permitted/162761
    func postInvalidateOAuth2BearerToken(
        _ request: PostOAuth2InvalidateTokenRequestV1
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV1: AuthAPIv1 {

    public func postOAuthRequestTokenData(
        _ request: PostOAuthRequestTokenRequestV1
    ) -> TwitterAPISessionDataTask {
        return session.send(request)
    }

    func postOAuthRequestToken(
        _ request: PostOAuthRequestTokenRequestV1
    ) -> TwitterAPISessionSpecializedTask<TwitterOAuthTokenV1> {
        return session.send(request)
            .specialized { data in
                guard let token = TwitterOAuthTokenV1(queryStringData: data) else {
                    throw TwitterAPIKitError.responseSerializeFailed(
                        reason: .cannotConvert(data: data, toTypeName: "TwitterOAuthTokenV1")
                    )
                }
                return token
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
        _ request: PostOAuthAccessTokenRequestV1
    ) -> TwitterAPISessionDataTask {
        return session.send(request)
    }

    func postOAuthAccessToken(
        _ request: PostOAuthAccessTokenRequestV1
    ) -> TwitterAPISessionSpecializedTask<TwitterOAuthAccessTokenV1> {
        return session.send(request)
            .specialized { data in
                guard let token = TwitterOAuthAccessTokenV1(queryStringData: data) else {
                    throw TwitterAPIKitError.responseSerializeFailed(
                        reason: .cannotConvert(data: data, toTypeName: "TwitterOAuthAccessTokenV1")
                    )
                }
                return token
            }
    }

    public func postInvalidateAccessToken(
        _ request: PostOAuthInvalidateTokenRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postOAuth2BearerTokenData(
        _ request: PostOAuth2TokenRequestV1
    ) -> TwitterAPISessionDataTask {
        return session.send(request)
    }

    func postOAuth2BearerToken(
        _ request: PostOAuth2TokenRequestV1
    ) -> TwitterAPISessionSpecializedTask<TwitterOAuth2BearerToken> {
        return session.send(request)
            .specialized { data in
                do {
                    guard let token = try TwitterOAuth2BearerToken(jsonData: data) else {
                        throw TwitterAPIKitError.responseSerializeFailed(
                            reason: .cannotConvert(data: data, toTypeName: "TwitterOAuth2BearerToken")
                        )
                    }
                    return token
                } catch let error {
                    throw TwitterAPIKitError.responseSerializeFailed(
                        reason: .jsonSerializationFailed(error: error)
                    )
                }
            }
    }

    public func postInvalidateOAuth2BearerToken(
        _ request: PostOAuth2InvalidateTokenRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
