import Foundation

open class RetweetAPIv1: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-statuses-retweet-id
    public func postRetweet(
        _ request: PostRetweetRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-statuses-unretweet-id
    public func postUnRetweet(
        _ request: PostUnRetweetRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-retweets-id
    public func getRetweets(
        _ request: GetRetweetsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-retweets_of_me
    public func getRetweetsOfMe(
        _ request: GetRetweetsOfMeRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-retweeters-ids
    public func getRetweeters(
        _ request: GetRetweetersRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
