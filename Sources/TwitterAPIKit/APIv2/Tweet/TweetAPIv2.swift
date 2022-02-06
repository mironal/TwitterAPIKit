import Foundation

public protocol TweetAPIv2 {
    /// https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets
    @discardableResult
    func getTweets(
        _ request: GetTweetsRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets-id
    @discardableResult
    func getTweet(
        _ request: GetTweetRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

}

extension TwitterAPIKit: TweetAPIv2 {
    public func getTweets(
        _ request: GetTweetsRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func getTweet(
        _ request: GetTweetRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }
}
