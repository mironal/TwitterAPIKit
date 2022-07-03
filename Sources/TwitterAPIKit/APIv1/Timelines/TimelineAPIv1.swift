import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/overview
open class TimelineAPIv1: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-home_timeline
    public func getHomeTimeline(
        _ request: GetStatusesHomeTimelineRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-mentions_timeline
    public func getMentionsTimeline(
        _ request: GetStatusesMentionsTimelineRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-user_timeline
    public func getUserTimeline(
        _ request: GetStatusesUserTimelineRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
