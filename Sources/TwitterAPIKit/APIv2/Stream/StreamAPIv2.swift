import Foundation

public protocol StreamAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/volume-streams/api-reference/get-tweets-sample-stream
    func sampleStream(
        _ request: GetTweetsSampleStreamRequestV2
    ) -> TwitterAPISessionStreamTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream-rules
    func getSearchStreamRules(
        _ request: GetTweetsSearchStreamRulesRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules#Validate
    func postSearchStreamRules(
        _ request: PostTweetsSearchStreamRulesRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream
    func searchStream(
        _ request: GetTweetsSearchStreamRequestV2
    ) -> TwitterAPISessionStreamTask
}

extension TwitterAPIKit.TwitterAPIImplV2: StreamAPIv2 {

    func sampleStream(_ request: GetTweetsSampleStreamRequestV2) -> TwitterAPISessionStreamTask {
        return session.send(streamRequest: request)
    }

    func getSearchStreamRules(
        _ request: GetTweetsSearchStreamRulesRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func postSearchStreamRules(
        _ request: PostTweetsSearchStreamRulesRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func searchStream(_ request: GetTweetsSearchStreamRequestV2) -> TwitterAPISessionStreamTask {
        return session.send(streamRequest: request)
    }
}
