import Foundation

public protocol BlockAndMuteAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/get-blocks-ids
    func getBlockIDs(
        _ request: GetBlocksIDsRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

}

extension TwitterAPIKit: BlockAndMuteAPIv1 {

    public func getBlockIDs(
        _ request: GetBlocksIDsRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }
}
