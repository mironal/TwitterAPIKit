import Foundation

public protocol TimelineAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-tweets
    @discardableResult
    func getUserTweets(
        _ request: GetUsersTweetsRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-mentions
    @discardableResult
    func getUserMensions(
        _ request: GetUsersMentionsRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask
}

extension TwitterAPIKit.TwitterAPIImplV2: TimelineAPIv2 {

    public func getUserTweets(
        _ request: GetUsersTweetsRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func getUserMensions(
        _ request: GetUsersMentionsRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }
}
