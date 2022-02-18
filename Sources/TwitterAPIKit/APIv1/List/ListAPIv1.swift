import Foundation

public protocol ListAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-list
    @discardableResult
    func getLists(
        _ request: GetListsListRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-members
    @discardableResult
    func getListMembers(
        _ request: GetListsMembersRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-members-show
    @discardableResult
    func getListMember(
        _ request: GetListsMembersShowRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-memberships
    @discardableResult
    func getListMemberships(
        _ request: GetListsMembershipsRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-ownerships
    @discardableResult
    func getListOwnerships(
        _ request: GetListsOwnershipsRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-show
    @discardableResult
    func getList(
        _ request: GetListsShowRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-statuses
    @discardableResult
    func getListStatuses(
        _ request: GetListsStatusesRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-subscribers
    @discardableResult
    func getListSubscribers(
        _ request: GetListsSubscribersRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-subscribers-show
    @discardableResult
    func getListSubscriber(
        _ request: GetListsSubscribersShowRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-subscriptions
    @discardableResult
    func getListSubscriptions(
        _ request: GetListsSubscriptionsRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-create
    @discardableResult
    func postCreateList(
        _ request: PostListsCreateRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-destroy
    @discardableResult
    func postDestroyList(
        _ request: PostListsDestroyRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-members-create
    @discardableResult
    func postAddListMember(
        _ request: PostListsMembersCreateRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-members-create_all
    @discardableResult
    func postAddListMembers(
        _ request: PostListsMembersCreateAllRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-members-destroy
    @discardableResult
    func postRemoveListMember(
        _ request: PostListsMembersDestroyRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-members-destroy_all
    @discardableResult
    func postRemoveListMembers(
        _ request: PostListsMembersDestroyAllRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-subscribers-create
    @discardableResult
    func postSubscribeList(
        _ request: PostListsSubscribersCreateRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-subscribers-destroy
    @discardableResult
    func postUnsubscribeList(
        _ request: PostListsSubscribersDestroyRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-update
    @discardableResult
    func postUpdateList(
        _ request: PostListsUpdateRequestV1
    ) -> TwitterAPISessionResponse

}

extension TwitterAPIKit.TwitterAPIImplV1: ListAPIv1 {

    public func getLists(
        _ request: GetListsListRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getListMembers(
        _ request: GetListsMembersRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getListMember(
        _ request: GetListsMembersShowRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getListMemberships(
        _ request: GetListsMembershipsRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getListOwnerships(
        _ request: GetListsOwnershipsRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getList(
        _ request: GetListsShowRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getListStatuses(
        _ request: GetListsStatusesRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getListSubscribers(
        _ request: GetListsSubscribersRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getListSubscriber(
        _ request: GetListsSubscribersShowRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getListSubscriptions(
        _ request: GetListsSubscriptionsRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postCreateList(
        _ request: PostListsCreateRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postDestroyList(
        _ request: PostListsDestroyRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postAddListMember(
        _ request: PostListsMembersCreateRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postAddListMembers(
        _ request: PostListsMembersCreateAllRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postRemoveListMember(
        _ request: PostListsMembersDestroyRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postRemoveListMembers(
        _ request: PostListsMembersDestroyAllRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postSubscribeList(
        _ request: PostListsSubscribersCreateRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postUnsubscribeList(
        _ request: PostListsSubscribersDestroyRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postUpdateList(
        _ request: PostListsUpdateRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }
}
