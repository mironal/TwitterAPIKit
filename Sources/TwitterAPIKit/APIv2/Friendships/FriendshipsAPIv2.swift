import Foundation

public protocol FriendshipsAPIv2 {
    /// https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-following
    func getFollowing(
        _ request: GetUsersFollowingRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV2: FriendshipsAPIv2 {

    func getFollowing(_ request: GetUsersFollowingRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

}
