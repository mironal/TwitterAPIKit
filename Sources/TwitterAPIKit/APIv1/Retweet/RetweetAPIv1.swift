import Foundation

public protocol RetweetAPIV1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-statuses-retweet-id
    @discardableResult
    func postRetweet(
        _ request: PostRetweetRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-statuses-unretweet-id
    @discardableResult
    func postUnRetweet(
        _ request: PostUnRetweetRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-retweets-id
    @discardableResult
    func getRetweets(
        _ request: GetRetweetsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-retweets_of_me
    @discardableResult
    func getRetweetsOfMe(
        _ request: GetRetweetsOfMeRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-retweeters-ids
    @discardableResult
    func getRetweeters(
        _ request: GetRetweetersRequestV1
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV1: RetweetAPIV1 {
    public func postRetweet(
        _ request: PostRetweetRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postUnRetweet(
        _ request: PostUnRetweetRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getRetweets(
        _ request: GetRetweetsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getRetweetsOfMe(
        _ request: GetRetweetsOfMeRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getRetweeters(
        _ request: GetRetweetersRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
