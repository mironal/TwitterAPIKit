import Foundation

public protocol BlockAndMuteAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/get-blocks-ids
    func getBlockIDs(
        _ request: GetBlocksIDsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/get-blocks-list
    func getBlockUsers(
        _ request: GetBlocksListRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/get-mutes-users-ids
    func getMuteIDs(
        _ request: GetMutesUsersIDsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/get-mutes-users-list
    func getMuteUsers(
        _ request: GetMutesUsersListRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-blocks-create
    func postBlockUser(
        _ request: PostBlocksCreateRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-blocks-destroy
    func postUnblockUser(
        _ request: PostBlocksDestroyRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-mutes-users-create
    func postMuteUser(
        _ request: PostMutesUsersCreateRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-mutes-users-destroy
    func postUnmuteUser(
        _ request: PostMutesUsersDestroyRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-users-report_spam
    func postReportSpam(
        _ request: PostUsersReportSpamRequestV1
    ) -> TwitterAPISessionJSONTask

}

extension TwitterAPIClient.TwitterAPIImplV1: BlockAndMuteAPIv1 {

    public func getBlockIDs(
        _ request: GetBlocksIDsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getBlockUsers(
        _ request: GetBlocksListRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getMuteIDs(
        _ request: GetMutesUsersIDsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getMuteUsers(
        _ request: GetMutesUsersListRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postBlockUser(
        _ request: PostBlocksCreateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postUnblockUser(
        _ request: PostBlocksDestroyRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postMuteUser(
        _ request: PostMutesUsersCreateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postUnmuteUser(
        _ request: PostMutesUsersDestroyRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postReportSpam(
        _ request: PostUsersReportSpamRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
