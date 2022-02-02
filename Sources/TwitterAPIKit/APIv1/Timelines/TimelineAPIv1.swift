import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/overview
public protocol TimelineAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-home_timeline
    @discardableResult
    func getHomeTimeline(
        _ request: GetHomeTimelineRequestV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-mentions_timeline
    @discardableResult
    func getMentionsTimeline(
        _ request: GetMentionsTimelineRequestV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-user_timeline
    @discardableResult
    func getUserTimeline(
        _ request: GetUserTimelineRequestV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

}

extension TwitterAPIKit: TimelineAPIv1 {
    public func getHomeTimeline(
        _ request: GetHomeTimelineRequestV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func getMentionsTimeline(
        _ request: GetMentionsTimelineRequestV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func getUserTimeline(
        _ request: GetUserTimelineRequestV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

}
