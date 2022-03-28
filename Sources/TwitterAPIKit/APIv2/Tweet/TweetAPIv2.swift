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

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/quote-tweets/api-reference/get-tweets-id-quote_tweets
    func getQuoteTweets(
        _ request: GetTweetsQuoteTweetsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/delete-tweets-id
    func deleteTweet(
        _ request: DeleteTweetRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/post-tweets
    func postTweet(
        _ request: PostTweetsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/hide-replies/api-reference/put-tweets-id-hidden
    func hideReply(
        _ request: PutTweetsHiddenRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV2: TweetAPIv2 {

    public func getTweets(_ request: GetTweetsRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getTweet(_ request: GetTweetRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getQuoteTweets(_ request: GetTweetsQuoteTweetsRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func deleteTweet(_ request: DeleteTweetRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func postTweet(_ request: PostTweetsRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func hideReply(_ request: PutTweetsHiddenRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
