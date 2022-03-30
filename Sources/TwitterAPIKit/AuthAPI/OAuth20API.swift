import Foundation

public protocol OAuth20API {

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

extension TwitterAPIKit.TwitterAuthAPIImpl: OAuth20API {
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
