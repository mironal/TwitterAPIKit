import Foundation

public protocol ApplicationAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/developer-utilities/rate-limit-status/api-reference/get-application-rate_limit_status
    @discardableResult
    func getRateLimit(
        _ request: GetApplicationRateLimitStatusRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

}

extension TwitterAPIKit.TwitterAPIImplV1: ApplicationAPIv1 {

    func getRateLimit(
        _ request: GetApplicationRateLimitStatusRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }
}
