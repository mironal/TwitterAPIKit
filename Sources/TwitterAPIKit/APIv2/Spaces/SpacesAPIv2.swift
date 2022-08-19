import Foundation

open class SpacesAPIv2: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id
    public func getSpace(
        _ request: GetSpaceRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces
    public func getSpaces(
        _ request: GetSpacesRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-by-creator-ids
    public func getSpacesByCreators(
        _ request: GetSpacesByCreatorIDsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-buyers
    public func getSpacesBuyers(
        _ request: GetSpacesBuyersRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-tweets
    public func getSPacesTweets(
        _ request: GetSpacesTweetsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/spaces/search/api-reference/get-spaces-search
    public func searchSpaces(
        _ request: GetSpacesSearchRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
