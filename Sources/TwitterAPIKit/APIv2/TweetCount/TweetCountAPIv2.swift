import Foundation

open class TweetCountAPIv2: TwitterAPIBase {
    /// https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-recent
    public func getTweetCountRecent(
        _ request: GetTweetsCountsRecentRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-all
    /// - Important: This endpoint is only available to those users who have been approved for Academic Research access.
    public func getTweetCountAll(
        _ request: GetTweetsCountsAllRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
