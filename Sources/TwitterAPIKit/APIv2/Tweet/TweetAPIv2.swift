import Foundation

public protocol TweetAPIv2 {
    /// https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets
    @discardableResult
    func getTweets(
        _ request: GetTweetsRequestV2
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets-id
    @discardableResult
    func getTweet(
        _ request: GetTweetRequestV2
    ) -> TwitterAPISessionTask

}

extension TwitterAPIKit.TwitterAPIImplV2: TweetAPIv2 {
    public func getTweets(
        _ request: GetTweetsRequestV2
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getTweet(
        _ request: GetTweetRequestV2
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }
}
