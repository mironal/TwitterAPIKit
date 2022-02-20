import Foundation

public protocol FriendshipsAPIv2 {
    /// https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-following
    func getFollowing(
        _ request: GetUsersFollowingRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-followers
    func getFollowers(
        _ request: GetUsersFollowersRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/post-users-source_user_id-following
    func postFollow(
        _ request: PostUsersFollowingRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV2: FriendshipsAPIv2 {

    func getFollowing(_ request: GetUsersFollowingRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getFollowers(_ request: GetUsersFollowersRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func postFollow(_ request: PostUsersFollowingRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
