import Foundation

public protocol ListAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/lists/list-tweets/api-reference/get-lists-id-tweets
    func getListTweets(
        _ request: GetListsTweetsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/lists/list-lookup/api-reference/get-lists-id
    func getList(
        _ request: GetListRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/lists/list-lookup/api-reference/get-users-id-owned_lists
    func getLists(
        _ request: GetUsersOwnedListsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/post-users-id-followed-lists
    func followList(
        _ request: PostUsersFollowedListsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/delete-users-id-followed-lists-list_id
    func unfollowList(
        _ request: DeleteUsersFollowedListsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/get-lists-id-followers
    func listFollowers(
        _ request: GetListsFollowersRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/get-users-id-followed_lists
    func followedLists(
        _ request: GetUsersFollowedListsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/post-lists-id-members
    func addListMember(
        _ request: PostListsMembersRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/delete-lists-id-members-user_id
    func removeListMember(
        _ request: DeleteListsMembersRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/get-users-id-list_memberships
    func getListMemberships(
        _ request: GetUsersListMembershipsRequestV2
    ) -> TwitterAPISessionJSONTask

    func getListMembers(
        _ request: GetListsMembersRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV2: ListAPIv2 {

    func getListTweets(_ request: GetListsTweetsRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getList(_ request: GetListRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getLists(_ request: GetUsersOwnedListsRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func followList(_ request: PostUsersFollowedListsRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func unfollowList(_ request: DeleteUsersFollowedListsRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func listFollowers(_ request: GetListsFollowersRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func followedLists(_ request: GetUsersFollowedListsRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func addListMember(_ request: PostListsMembersRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func removeListMember(_ request: DeleteListsMembersRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getListMemberships(_ request: GetUsersListMembershipsRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getListMembers(_ request: GetListsMembersRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
