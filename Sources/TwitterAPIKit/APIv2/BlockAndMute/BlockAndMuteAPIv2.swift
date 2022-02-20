import Foundation

public protocol BlockAndMuteAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/get-users-blocking
    func getBlockUsers(
        _ request: GetUsersBlockingRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV2: BlockAndMuteAPIv2 {

    func getBlockUsers(_ request: GetUsersBlockingRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
