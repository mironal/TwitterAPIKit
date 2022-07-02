import Foundation

open class FriendshipsAPIv1: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-followers-ids
    public func getFollowerIDs(
        _ request: GetFollowersIDsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-followers-list
    public func getFollowers(
        _ request: GetFollowersListRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friends-ids
    public func getFriendIDs(
        _ request: GetFriendsIDsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friends-list
    public func getFriends(
        _ request: GetFriendsListRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-incoming
    public func getFriendshipsIncoming(
        _ request: GetFriendshipsIncomingRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-lookup
    public func getFriendshipsLookup(
        _ request: GetFriendshipsLookupRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-no_retweets-ids
    public func getFriendshipsNoRetweetsIDs(
        _ request: GetFriendshipsNoRetweetsIDsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-outgoing
    public func getFriendshipsOutgoing(
        _ request: GetFriendshipsOutgoingRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-show
    public func getFriendships(
        _ request: GetFriendshipsShowRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/post-friendships-create
    public func postFollowUser(
        _ request: PostFriendshipsCreateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/post-friendships-destroy
    public func postUnfollowUser(
        _ request: PostFriendshipsDestroyRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/post-friendships-update
    public func postFriendshipsUpdate(
        _ request: PostFriendshipsUpdateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
