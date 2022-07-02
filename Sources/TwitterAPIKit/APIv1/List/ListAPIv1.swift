import Foundation

public protocol ListAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-list
    func getLists(
        _ request: GetListsListRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-members
    func getListMembers(
        _ request: GetListsMembersRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-members-show
    func getListMember(
        _ request: GetListsMembersShowRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-memberships
    func getListMemberships(
        _ request: GetListsMembershipsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-ownerships
    func getListOwnerships(
        _ request: GetListsOwnershipsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-show
    func getList(
        _ request: GetListsShowRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-statuses
    func getListStatuses(
        _ request: GetListsStatusesRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-subscribers
    func getListSubscribers(
        _ request: GetListsSubscribersRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-subscribers-show
    func getListSubscriber(
        _ request: GetListsSubscribersShowRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-subscriptions
    func getListSubscriptions(
        _ request: GetListsSubscriptionsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-create
    func postCreateList(
        _ request: PostListsCreateRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-destroy
    func postDestroyList(
        _ request: PostListsDestroyRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-members-create
    func postAddListMember(
        _ request: PostListsMembersCreateRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-members-create_all
    func postAddListMembers(
        _ request: PostListsMembersCreateAllRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-members-destroy
    func postRemoveListMember(
        _ request: PostListsMembersDestroyRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-members-destroy_all
    func postRemoveListMembers(
        _ request: PostListsMembersDestroyAllRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-subscribers-create
    func postSubscribeList(
        _ request: PostListsSubscribersCreateRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-subscribers-destroy
    func postUnsubscribeList(
        _ request: PostListsSubscribersDestroyRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-update
    func postUpdateList(
        _ request: PostListsUpdateRequestV1
    ) -> TwitterAPISessionJSONTask

}

extension TwitterAPIClient.TwitterAPIImplV1: ListAPIv1 {

    public func getLists(
        _ request: GetListsListRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getListMembers(
        _ request: GetListsMembersRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getListMember(
        _ request: GetListsMembersShowRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getListMemberships(
        _ request: GetListsMembershipsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getListOwnerships(
        _ request: GetListsOwnershipsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getList(
        _ request: GetListsShowRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getListStatuses(
        _ request: GetListsStatusesRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getListSubscribers(
        _ request: GetListsSubscribersRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getListSubscriber(
        _ request: GetListsSubscribersShowRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getListSubscriptions(
        _ request: GetListsSubscriptionsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postCreateList(
        _ request: PostListsCreateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postDestroyList(
        _ request: PostListsDestroyRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postAddListMember(
        _ request: PostListsMembersCreateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postAddListMembers(
        _ request: PostListsMembersCreateAllRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postRemoveListMember(
        _ request: PostListsMembersDestroyRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postRemoveListMembers(
        _ request: PostListsMembersDestroyAllRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postSubscribeList(
        _ request: PostListsSubscribersCreateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postUnsubscribeList(
        _ request: PostListsSubscribersDestroyRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postUpdateList(
        _ request: PostListsUpdateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
