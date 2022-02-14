import Foundation

public protocol LikeAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-tweets-id-liking_users
    @discardableResult
    func getLikingUsers(
        _ request: GetTweetsLikingUsersRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-users-id-liked_tweets
    @discardableResult
    func getLikedTweets(
        _ request: GetUsersLikedTweetsRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/post-users-id-likes
    @discardableResult
    func postLike(
        _ request: PostUsersLikesRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/delete-users-id-likes-tweet_id
    @discardableResult
    func deleteLike(
        _ request: DeleteUsersLikesRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

}

extension TwitterAPIKit.TwitterAPIImpl: LikeAPIv2 {
    public func getLikingUsers(
        _ request: GetTweetsLikingUsersRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func getLikedTweets(
        _ request: GetUsersLikedTweetsRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func postLike(
        _ request: PostUsersLikesRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func deleteLike(
        _ request: DeleteUsersLikesRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }
}
