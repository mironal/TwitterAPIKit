import Foundation

public protocol ApplicationAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/developer-utilities/rate-limit-status/api-reference/get-application-rate_limit_status
    func getRateLimit(
        _ request: GetApplicationRateLimitStatusRequestV1
    ) -> TwitterAPISessionJSONTask

}

extension TwitterAPIClient.TwitterAPIImplV1: ApplicationAPIv1 {
    func getRateLimit(_ request: GetApplicationRateLimitStatusRequestV1) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
