import Foundation

/// Creates a new message for a DM Conversation specified by DM Conversation ID
/// Required OAuth 2.0 scopes: dm.write, tweet.read, users.read
open class PostDmConversationByIdRequestV2: TwitterAPIRequest {

    /// The DM Conversation ID.
    public let dmConversationID: String
    /// Attachments to a DM Event.
    public let attachments: [String]?
    /// Text of the message.
    public let text: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/dm_conversations/\(dmConversationID)/messages"
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        if let attachments = attachments {
            p["attachments"] = attachments.map { ["media_id": $0] }
        }
        text.map { p["text"] = $0 }
        return p
    }

    public init(
        dmConversationID: String,
        attachments: [String]? = .none,
        text: String? = .none
    ) {
        self.dmConversationID = dmConversationID
        self.attachments = attachments
        self.text = text
    }
}
