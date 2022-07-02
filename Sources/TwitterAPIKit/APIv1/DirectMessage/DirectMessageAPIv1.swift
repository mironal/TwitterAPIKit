import Foundation

open class DirectMessageAPIv1: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/sending-and-receiving/api-reference/new-event
    public func postDirectMessage(
        _ request: PostDirectMessageRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/sending-and-receiving/api-reference/delete-message-event
    public func deleteDirectMessage(
        _ request: DeleteDirectMessageRequestV1
    ) -> TwitterAPISessionDataTask {  // 204 - No Content
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/sending-and-receiving/api-reference/get-event
    public func getDirectMessage(
        _ request: GetDirectMessageRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/sending-and-receiving/api-reference/list-events
    public func getDirectMessageList(
        _ request: GetDirectMessageListRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/typing-indicator-and-read-receipts/api-reference/new-read-receipt
    public func postDirectMessageMarkRead(
        _ request: PostDirectMessagesMarkReadRequestV1
    ) -> TwitterAPISessionDataTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/typing-indicator-and-read-receipts/api-reference/new-typing-indicator
    public func postDirectMessageTypingIndicator(
        _ request: PostDirectMessagesIndicateTypingRequestV1
    ) -> TwitterAPISessionDataTask {
        return session.send(request)
    }
}
