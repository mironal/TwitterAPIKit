import Foundation

public protocol TimelineAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-home_timeline
    @discardableResult
    func getHomeTimeline(
        _ parameters: GetTimelineParametersV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-mentions_timeline
    @discardableResult
    func getMentionsTimeline(
        _ parameters: GetTimelineParametersV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-user_timeline
    @discardableResult
    func getUserTimeline(
        _ parameters: GetUserTimelineParametersV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

}

extension TwitterAPIKit: TimelineAPIv1 {
    public func getHomeTimeline(
        _ parameters: GetTimelineParametersV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.request(
            .get,
            path: "/1.1/statuses/home_timeline.json",
            with: parameters,
            completionHandler: completionHandler
        )
    }

    public func getMentionsTimeline(
        _ parameters: GetTimelineParametersV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.request(
            .get,
            path: "/1.1/statuses/mentions_timeline.json",
            with: parameters,
            completionHandler: completionHandler
        )
    }

    public func getUserTimeline(
        _ parameters: GetUserTimelineParametersV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.request(
            .get,
            path: "/1.1/statuses/user_timeline.json",
            with: parameters,
            completionHandler: completionHandler
        )
    }

}
