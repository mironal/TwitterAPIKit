import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/sending-and-receiving/api-reference/new-event
open class PostDirectMessageRequestV1: TwitterAPIRequest {

    /// message_create.target.recipient_id
    public let targetUserID: String

    /// message_create.message_data.text
    public let message: String

    // TODO: Other parameters (attachment.type, attachment.media.id ...)

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/direct_messages/events/new.json"
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    open var parameters: [String: Any]? {
        return [
            "event": [
                "type": "message_create",
                "message_create": [
                    "target": [
                        "recipient_id": targetUserID
                    ],
                    "message_data": [
                        "text": message
                    ],
                ],
            ]
        ]
    }

    public init(targetUserID: String, message: String) {
        self.targetUserID = targetUserID
        self.message = message
    }
}
