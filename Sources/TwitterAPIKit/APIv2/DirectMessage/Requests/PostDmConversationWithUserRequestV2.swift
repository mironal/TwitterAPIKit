import Foundation

/// Creates a new message for a DM Conversation with a participant user by ID
/// Required OAuth 2.0 scopes: dm.write, tweet.read, users.read
open class PostDmConversationWithUserRequestV2: TwitterAPIRequest {

    /// The ID of the recipient user that will receive the DM.
    public let participantID: String
    /// Attachments to a DM Event.
    public let attachments: [String]?
    /// Text of the message.
    public let text: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/dm_conversations/with/\(participantID)/messages"
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
        participantID: String,
        attachments: [String]? = .none,
        text: String? = .none
    ) {
        self.participantID = participantID
        self.attachments = attachments
        self.text = text
    }
}
