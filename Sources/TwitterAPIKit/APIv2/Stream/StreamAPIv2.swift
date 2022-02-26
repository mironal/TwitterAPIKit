import Foundation

public protocol StreamAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/volume-streams/api-reference/get-tweets-sample-stream
    func sampleStream(
        _ request: GetTweetsSampleStreamRequestV2
    ) -> TwitterAPISessionStreamTask
}

extension TwitterAPIKit.TwitterAPIImplV2: StreamAPIv2 {
    func sampleStream(_ request: GetTweetsSampleStreamRequestV2) -> TwitterAPISessionStreamTask {
        return session.send(streamRequest: request)
    }
}
