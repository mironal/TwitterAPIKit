import Foundation

open class OAuth20API: TwitterAPIBase {

    // MARK: - OAuth 2.0 Bearer Token

    /// https://developer.twitter.com/en/docs/authentication/api-reference/token
    public func postOAuth2BearerTokenData(
        _ request: PostOAuth2TokenRequestV1
    ) -> TwitterAPISessionDataTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/authentication/api-reference/token
    public func postOAuth2BearerToken(
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

    /// https://developer.twitter.com/en/docs/authentication/api-reference/invalidate_bearer_token
    ///
    ///May not work. {"errors":[{"code":348,"message":"Client application is not permitted to to invalidate this token."}]}
    /// https://twittercommunity.com/t/oauth2-invalidate-token-not-working-for-app-only-authentication-tokens/133108
    /// https://twittercommunity.com/t/invalidate-bearer-client-application-not-permitted/162761
    public func postInvalidateOAuth2BearerToken(
        _ request: PostOAuth2InvalidateTokenRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    // MARK: - OAuth 2.0 Authorization Code Flow with PKCE

    /// Create OAuth 2.0  Authorize URL
    public func makeOAuth2AuthorizeURL(_ request: GetOAuth2AuthorizeRequestV1) -> URL? {
        return try? request.buildRequest(environment: session.environment).url
    }

    public func postOAuth2AccessTokenData(
        _ request: PostOAuth2AccessTokenRequestV2
    ) -> TwitterAPISessionDataTask {
        return session.send(request)
    }

    public func postOAuth2AccessToken(
        _ request: PostOAuth2AccessTokenRequestV2
    ) -> TwitterAPISessionSpecializedTask<TwitterOAuth2AccessToken> {
        return postOAuth2AccessTokenData(request)
            .specialized { try TwitterOAuth2AccessToken.fromResponse(data: $0) }
    }

    public func postOAuth2RefreshTokenData(
        _ request: PostOAuth2RefreshTokenRequestV2
    ) -> TwitterAPISessionDataTask {
        return session.send(request)
    }

    public func postOAuth2RefreshToken(
        _ request: PostOAuth2RefreshTokenRequestV2
    ) -> TwitterAPISessionSpecializedTask<TwitterOAuth2AccessToken> {
        return postOAuth2RefreshTokenData(request)
            .specialized { try TwitterOAuth2AccessToken.fromResponse(data: $0) }

    }

    public func postOAuth2RevokeToken(
        _ request: PostOAuth2RevokeTokenRequestV2
    ) -> TwitterAPISessionDataTask {
        return session.send(request)
    }
}
