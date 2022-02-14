import Foundation

public protocol TweetAPIv2 {
    /// https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets
    @discardableResult
    func getTweets(
        _ request: GetTweetsRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets-id
    @discardableResult
    func getTweet(
        _ request: GetTweetRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

}

extension TwitterAPIKit.TwitterAPIImpl: TweetAPIv2 {
    public func getTweets(
        _ request: GetTweetsRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func getTweet(
        _ request: GetTweetRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }
}
