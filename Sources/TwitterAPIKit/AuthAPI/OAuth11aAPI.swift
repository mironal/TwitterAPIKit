import Foundation

public protocol OAuth11aAPI {
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
}

extension TwitterAPIKit.TwitterAuthAPIImpl: OAuth11aAPI {
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
}
