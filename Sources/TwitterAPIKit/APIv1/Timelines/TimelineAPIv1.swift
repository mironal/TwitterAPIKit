import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/overview
public protocol TimelineAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-home_timeline
    @discardableResult
    func getHomeTimeline(
        _ request: GetStatusesHomeTimelineRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-mentions_timeline
    @discardableResult
    func getMentionsTimeline(
        _ request: GetStatusesMentionsTimelineRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-user_timeline
    @discardableResult
    func getUserTimeline(
        _ request: GetStatusesUserTimelineRequestV1
    ) -> TwitterAPISessionResponse

}

extension TwitterAPIKit.TwitterAPIImplV1: TimelineAPIv1 {
    public func getHomeTimeline(
        _ request: GetStatusesHomeTimelineRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getMentionsTimeline(
        _ request: GetStatusesMentionsTimelineRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getUserTimeline(
        _ request: GetStatusesUserTimelineRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

}
