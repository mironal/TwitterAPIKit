import Foundation

open class ApplicationAPIv1: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/developer-utilities/rate-limit-status/api-reference/get-application-rate_limit_status
    public func getRateLimit(
        _ request: GetApplicationRateLimitStatusRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
