import Foundation

public protocol LikeAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-tweets-id-liking_users
    func getLikingUsers(
        _ request: GetTweetsLikingUsersRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-users-id-liked_tweets
    func getLikedTweets(
        _ request: GetUsersLikedTweetsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/post-users-id-likes
    func postLike(
        _ request: PostUsersLikesRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/delete-users-id-likes-tweet_id
    func deleteLike(
        _ request: DeleteUsersLikesRequestV2
    ) -> TwitterAPISessionJSONTask

}

extension TwitterAPIKit.TwitterAPIImplV2: LikeAPIv2 {
    public func getLikingUsers(
        _ request: GetTweetsLikingUsersRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getLikedTweets(
        _ request: GetUsersLikedTweetsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postLike(
        _ request: PostUsersLikesRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func deleteLike(
        _ request: DeleteUsersLikesRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
