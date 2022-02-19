import Foundation

public protocol FriendshipsAPIV1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-followers-ids
    @discardableResult
    func getFollowerIDs(
        _ request: GetFollowersIDsRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-followers-list
    @discardableResult
    func getFollowers(
        _ request: GetFollowersListRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friends-ids
    @discardableResult
    func getFriendIDs(
        _ request: GetFriendsIDsRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friends-list
    @discardableResult
    func getFriends(
        _ request: GetFriendsListRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-incoming
    @discardableResult
    func getFriendshipsIncoming(
        _ request: GetFriendshipsIncomingRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-lookup
    @discardableResult
    func getFriendshipsLookup(
        _ request: GetFriendshipsLookupRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-no_retweets-ids
    @discardableResult
    func getFriendshipsNoRetweetsIDs(
        _ request: GetFriendshipsNoRetweetsIDsRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-outgoing
    @discardableResult
    func getFriendshipsOutgoing(
        _ request: GetFriendshipsOutgoingRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-show
    @discardableResult
    func getFriendships(
        _ request: GetFriendshipsShowRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/post-friendships-create
    @discardableResult
    func postFollowUser(
        _ request: PostFriendshipsCreateRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/post-friendships-destroy
    @discardableResult
    func postUnfollowUser(
        _ request: PostFriendshipsDestroyRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/post-friendships-update
    @discardableResult
    func postFriendshipsUpdate(
        _ request: PostFriendshipsUpdateRequestV1
    ) -> TwitterAPISessionTask

}

extension TwitterAPIKit.TwitterAPIImplV1: FriendshipsAPIV1 {

    public func getFollowerIDs(
        _ request: GetFollowersIDsRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getFollowers(
        _ request: GetFollowersListRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getFriendIDs(
        _ request: GetFriendsIDsRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getFriends(
        _ request: GetFriendsListRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getFriendshipsIncoming(
        _ request: GetFriendshipsIncomingRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getFriendshipsLookup(
        _ request: GetFriendshipsLookupRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getFriendshipsNoRetweetsIDs(
        _ request: GetFriendshipsNoRetweetsIDsRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getFriendshipsOutgoing(
        _ request: GetFriendshipsOutgoingRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getFriendships(
        _ request: GetFriendshipsShowRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func postFollowUser(
        _ request: PostFriendshipsCreateRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func postUnfollowUser(
        _ request: PostFriendshipsDestroyRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func postFriendshipsUpdate(
        _ request: PostFriendshipsUpdateRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }
}
