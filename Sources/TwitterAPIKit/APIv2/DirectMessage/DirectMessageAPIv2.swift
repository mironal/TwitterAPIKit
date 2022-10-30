import Foundation

open class DirectMessageAPIv2: TwitterAPIBase {
    /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/lookup/api-reference/get-dm_events
    public func getDmEvents(
        _ request: GetDmEventsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
