import Foundation

public protocol TweetAPIv2 {
    /// https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets
    func getTweets(
        _ request: GetTweetsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets-id
    func getTweet(
        _ request: GetTweetRequestV2
    ) -> TwitterAPISessionJSONTask

}

extension TwitterAPIKit.TwitterAPIImplV2: TweetAPIv2 {
    public func getTweets(
        _ request: GetTweetsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getTweet(
        _ request: GetTweetRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
