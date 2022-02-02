import Foundation

public protocol TwitterAPIv1 {

    // MARK: - Timeline

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-home_timeline
    @discardableResult
    func getHomeTimeline(
        _ parameters: GetTimelineParameters,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-mentions_timeline
    @discardableResult
    func getMentionsTimeline(
        _ parameters: GetTimelineParameters,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-user_timeline
    @discardableResult
    func getUserTimeline(
        _ parameters: GetUserTimelineParameters,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

    // MARK: - Status

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-statuses-update
    @discardableResult
    func postUpdateStatus(
        _ parameters: PostUpdateStatusParameters,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

}
