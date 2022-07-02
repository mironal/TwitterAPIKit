import Foundation

public protocol SearchAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-recent
    func searchTweetsRecent(
        _ request: GetTweetsSearchRecentRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-all
    /// - Important: This endpoint is only available to those users who have been approved for Academic Research access.
    func searchTweetsAll(
        _ request: GetTweetsSearchAllRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIClient.TwitterAPIImplV2: SearchAPIv2 {

    func searchTweetsRecent(_ request: GetTweetsSearchRecentRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func searchTweetsAll(_ request: GetTweetsSearchAllRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
