import Foundation

public protocol FriendshipsAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-followers-ids
    func getFollowerIDs(
        _ request: GetFollowersIDsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-followers-list
    func getFollowers(
        _ request: GetFollowersListRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friends-ids
    func getFriendIDs(
        _ request: GetFriendsIDsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friends-list
    func getFriends(
        _ request: GetFriendsListRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-incoming
    func getFriendshipsIncoming(
        _ request: GetFriendshipsIncomingRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-lookup
    func getFriendshipsLookup(
        _ request: GetFriendshipsLookupRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-no_retweets-ids
    func getFriendshipsNoRetweetsIDs(
        _ request: GetFriendshipsNoRetweetsIDsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-outgoing
    func getFriendshipsOutgoing(
        _ request: GetFriendshipsOutgoingRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-show
    func getFriendships(
        _ request: GetFriendshipsShowRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/post-friendships-create
    func postFollowUser(
        _ request: PostFriendshipsCreateRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/post-friendships-destroy
    func postUnfollowUser(
        _ request: PostFriendshipsDestroyRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/post-friendships-update
    func postFriendshipsUpdate(
        _ request: PostFriendshipsUpdateRequestV1
    ) -> TwitterAPISessionJSONTask

}

extension TwitterAPIClient.TwitterAPIImplV1: FriendshipsAPIv1 {

    public func getFollowerIDs(
        _ request: GetFollowersIDsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getFollowers(
        _ request: GetFollowersListRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getFriendIDs(
        _ request: GetFriendsIDsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getFriends(
        _ request: GetFriendsListRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getFriendshipsIncoming(
        _ request: GetFriendshipsIncomingRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getFriendshipsLookup(
        _ request: GetFriendshipsLookupRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getFriendshipsNoRetweetsIDs(
        _ request: GetFriendshipsNoRetweetsIDsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getFriendshipsOutgoing(
        _ request: GetFriendshipsOutgoingRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getFriendships(
        _ request: GetFriendshipsShowRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postFollowUser(
        _ request: PostFriendshipsCreateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postUnfollowUser(
        _ request: PostFriendshipsDestroyRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postFriendshipsUpdate(
        _ request: PostFriendshipsUpdateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
