import Foundation

open class SearchAPIv2: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-recent
    public func searchTweetsRecent(
        _ request: GetTweetsSearchRecentRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-all
    /// - Important: This endpoint is only available to those users who have been approved for Academic Research access.
    public func searchTweetsAll(
        _ request: GetTweetsSearchAllRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
