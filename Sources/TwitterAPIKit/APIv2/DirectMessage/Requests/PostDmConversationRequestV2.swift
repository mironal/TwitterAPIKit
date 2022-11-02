import Foundation

/// Creates a new DM Conversation.
/// Required OAuth 2.0 scopes: dm.write, tweet.read, users.read
open class PostDmConversationRequestV2: TwitterAPIRequest {

    /// The conversation type that is being created.
    public enum ConversationType: String {
        case group = "Group"
    }

    /// The conversation type that is being created.
    public let conversationType: ConversationType
    /// Participants for the DM Conversation.
    public let participantIDs: [String]
    /// Attachments to a DM Event.
    public let attachments: [String]?
    /// Text of the message.
    public let text: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/dm_conversations"
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["conversation_type"] = conversationType.rawValue
        p["participant_ids"] = participantIDs
        var message = [String: Any]()
        text.map { message["text"] = $0 }
        if let attachments = attachments {
            message["attachments"] = attachments.map { ["media_id": $0] }
        }
        p["message"] = message
        return p
    }

    public init(
        conversationType: ConversationType,
        participantIDs: [String],
        attachments: [String]? = .none,
        text: String? = .none
    ) {
        self.conversationType = conversationType
        self.participantIDs = participantIDs
        self.attachments = attachments
        self.text = text
    }
}
