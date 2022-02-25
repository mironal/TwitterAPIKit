import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/typing-indicator-and-read-receipts/api-reference/new-typing-indicator
open class PostDirectMessagesIndicateTypingRequestV1: TwitterAPIRequest {

    public let recipientID: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/direct_messages/indicate_typing.json"
    }

    open var parameters: [String: Any] {
        return ["recipient_id": recipientID]
    }

    public init(
        recipientID: String
    ) {
        self.recipientID = recipientID
    }
}
