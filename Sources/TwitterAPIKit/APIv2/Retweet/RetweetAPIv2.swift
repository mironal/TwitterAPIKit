import Foundation

public protocol RetweetAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/get-tweets-id-retweeted_by
    @discardableResult
    func getRetweetedBy(
        _ request: GetTweetsRetweetedByRequestV2
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/post-users-id-retweets
    @discardableResult
    func postRetweet(
        _ request: PostUsersRetweetsRequestV2
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/delete-users-id-retweets-tweet_id
    @discardableResult
    func deleteRetweet(
        _ request: DeleteUsersRetweetsRequestV2
    ) -> TwitterAPISessionResponse
}

extension TwitterAPIKit.TwitterAPIImplV2: RetweetAPIv2 {

    public func getRetweetedBy(
        _ request: GetTweetsRetweetedByRequestV2
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postRetweet(
        _ request: PostUsersRetweetsRequestV2
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func deleteRetweet(
        _ request: DeleteUsersRetweetsRequestV2
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }
}
