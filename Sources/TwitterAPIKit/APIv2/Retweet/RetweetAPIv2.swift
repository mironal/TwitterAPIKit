import Foundation

public protocol RetweetAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/get-tweets-id-retweeted_by
    func getRetweetedBy(
        _ request: GetTweetsRetweetedByRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/post-users-id-retweets
    func postRetweet(
        _ request: PostUsersRetweetsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/delete-users-id-retweets-tweet_id
    func deleteRetweet(
        _ request: DeleteUsersRetweetsRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIClient.TwitterAPIImplV2: RetweetAPIv2 {

    public func getRetweetedBy(
        _ request: GetTweetsRetweetedByRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postRetweet(
        _ request: PostUsersRetweetsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func deleteRetweet(
        _ request: DeleteUsersRetweetsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
