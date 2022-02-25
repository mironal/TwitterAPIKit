import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/typing-indicator-and-read-receipts/api-reference/new-read-receipt
open class PostDirectMessagesMarkReadRequestV1: TwitterAPIRequest {

    /// Message ID
    public let lastReadEventID: String

    /// User ID
    public let recipientID: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/direct_messages/mark_read.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()

        p["last_read_event_id"] = lastReadEventID
        p["recipient_id"] = recipientID

        return p
    }

    public init(
        lastReadEventID: String,
        recipientID: String
    ) {
        self.lastReadEventID = lastReadEventID
        self.recipientID = recipientID
    }
}
