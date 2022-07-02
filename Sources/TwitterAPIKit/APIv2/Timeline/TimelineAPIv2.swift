import Foundation

public protocol TimelineAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-tweets
    func getUserTweets(
        _ request: GetUsersTweetsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-mentions
    func getUserMensions(
        _ request: GetUsersMentionsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// a.k.a Home Timeline
    /// https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-reverse-chronological
    func getUserReverseChronological(
        _ request: GetUsersTimelinesReverseChronologicalRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIClient.TwitterAPIImplV2: TimelineAPIv2 {

    public func getUserTweets(
        _ request: GetUsersTweetsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getUserMensions(
        _ request: GetUsersMentionsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getUserReverseChronological(
        _ request: GetUsersTimelinesReverseChronologicalRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
