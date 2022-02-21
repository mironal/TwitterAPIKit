import Foundation

public protocol SpacesAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id
    func getSpace(
        _ request: GetSpaceRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces
    func getSpaces(
        _ request: GetSpacesRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-by-creator-ids
    func getSpacesByCreators(
        _ request: GetSpacesByCreatorIDsRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-buyers
    func getSpacesBuyers(
        _ request: GetSpacesBuyersRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV2: SpacesAPIv2 {

    func getSpace(_ request: GetSpaceRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getSpaces(_ request: GetSpacesRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getSpacesByCreators(_ request: GetSpacesByCreatorIDsRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getSpacesBuyers(_ request: GetSpacesBuyersRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
