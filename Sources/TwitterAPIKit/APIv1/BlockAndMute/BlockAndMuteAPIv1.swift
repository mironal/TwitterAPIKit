import Foundation

public protocol BlockAndMuteAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/get-blocks-ids
    @discardableResult
    func getBlockIDs(
        _ request: GetBlocksIDsRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/get-blocks-list
    @discardableResult
    func getBlockUsers(
        _ request: GetBlocksListRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/get-mutes-users-ids
    @discardableResult
    func getMuteIDs(
        _ request: GetMutesUsersIDsRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/get-mutes-users-list
    @discardableResult
    func getMuteUsers(
        _ request: GetMutesUsersListRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-blocks-create
    @discardableResult
    func postBlockUser(
        _ request: PostBlocksCreateRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-blocks-destroy
    @discardableResult
    func postUnblockUser(
        _ request: PostBlocksDestroyRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-mutes-users-create
    @discardableResult
    func postMuteUser(
        _ request: PostMutesUsersCreateRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-mutes-users-destroy
    @discardableResult
    func postUnmuteUser(
        _ request: PostMutesUsersDestroyRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-users-report_spam
    @discardableResult
    func postReportSpam(
        _ request: PostUsersReportSpamRequestV1
    ) -> TwitterAPISessionTask

}

extension TwitterAPIKit.TwitterAPIImplV1: BlockAndMuteAPIv1 {

    public func getBlockIDs(
        _ request: GetBlocksIDsRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getBlockUsers(
        _ request: GetBlocksListRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getMuteIDs(
        _ request: GetMutesUsersIDsRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getMuteUsers(
        _ request: GetMutesUsersListRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func postBlockUser(
        _ request: PostBlocksCreateRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func postUnblockUser(
        _ request: PostBlocksDestroyRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func postMuteUser(
        _ request: PostMutesUsersCreateRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func postUnmuteUser(
        _ request: PostMutesUsersDestroyRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func postReportSpam(
        _ request: PostUsersReportSpamRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }
}
