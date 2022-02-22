import Foundation

public protocol SearchAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-recent
    func searchTweets(
        _ request: GetTweetsSearchRecentRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV2: SearchAPIv2 {
    func searchTweets(_ request: GetTweetsSearchRecentRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
