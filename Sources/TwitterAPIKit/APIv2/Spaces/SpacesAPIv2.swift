import Foundation

public protocol SpacesAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id
    func getSpace(
        _ request: GetSpaceRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV2: SpacesAPIv2 {
    func getSpace(_ request: GetSpaceRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
