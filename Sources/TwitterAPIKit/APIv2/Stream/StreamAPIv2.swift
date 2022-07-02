import Foundation

open class StreamAPIv2: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/volume-streams/api-reference/get-tweets-sample-stream
    public func sampleStream(
        _ request: GetTweetsSampleStreamRequestV2
    ) -> TwitterAPISessionStreamTask {
        return session.send(streamRequest: request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream-rules
    public func getSearchStreamRules(
        _ request: GetTweetsSearchStreamRulesRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules#Validate
    public func postSearchStreamRules(
        _ request: PostTweetsSearchStreamRulesRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream
    public func searchStream(
        _ request: GetTweetsSearchStreamRequestV2
    ) -> TwitterAPISessionStreamTask {
        return session.send(streamRequest: request)
    }
}
