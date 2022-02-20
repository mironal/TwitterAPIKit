import Foundation

public protocol TweetCountAPIv2 {
    /// https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-recent
    func getTweetCountRecent(
        _ request: GetTweetsCountsRecentRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV2: TweetCountAPIv2 {
    func getTweetCountRecent(
        _ request: GetTweetsCountsRecentRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
