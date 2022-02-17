import Foundation

public protocol TimelineAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-tweets
    @discardableResult
    func getUserTweets(
        _ request: GetUsersTweetsRequestV2
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-mentions
    @discardableResult
    func getUserMensions(
        _ request: GetUsersMentionsRequestV2
    ) -> TwitterAPISessionResponse
}

extension TwitterAPIKit.TwitterAPIImplV2: TimelineAPIv2 {

    public func getUserTweets(
        _ request: GetUsersTweetsRequestV2
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getUserMensions(
        _ request: GetUsersMentionsRequestV2
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }
}
