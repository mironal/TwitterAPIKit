import Foundation

open class TimelineAPIv2: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-tweets
    public func getUserTweets(
        _ request: GetUsersTweetsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-mentions
    public func getUserMensions(
        _ request: GetUsersMentionsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// a.k.a Home Timeline
    /// https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-reverse-chronological
    public func getUserReverseChronological(
        _ request: GetUsersTimelinesReverseChronologicalRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
