import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-statuses-update
open class PostStatusesUpdateRequestV1: TwitterAPIRequest {

    public let status: String
    public let inReplyToStatusID: String?
    public let autoPopulateReplyMetadata: Bool?
    public let excludeReplyUserIDs: [String]?
    public let attachmentUrl: String?
    public let mediaIDs: [String]?
    public let possiblySensitive: Bool?
    public let location: TwitterCoordinateV1?
    public let placeID: String?
    public let displayCoordinates: Bool?
    public let trimUser: Bool?
    public let enableDMcommands: Bool?
    public let failDMcommands: Bool?
    public let cardUri: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/statuses/update.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["status"] = status
        inReplyToStatusID.map { p["in_reply_to_status_id"] = $0 }
        autoPopulateReplyMetadata.map { p["auto_populate_reply_metadata"] = $0 }
        excludeReplyUserIDs.map { p["exclude_reply_user_ids"] = $0.joined(separator: ",") }
        attachmentUrl.map { p["attachment_url"] = $0 }
        mediaIDs.map { p["media_ids"] = $0.joined(separator: ",") }
        possiblySensitive.map { p["possibly_sensitive"] = $0 }
        location?.bind(param: &p)
        placeID.map { p["place_id"] = $0 }
        displayCoordinates.map { p["display_coordinates"] = $0 }
        trimUser.map { p["trim_user"] = $0 }
        enableDMcommands.map { p["enable_dmcommands"] = $0 }
        failDMcommands.map { p["fail_dmcommands"] = $0 }
        cardUri.map { p["card_uri"] = $0 }
        return p
    }

    public init(
        status: String,
        inReplyToStatusID: String? = .none,
        autoPopulateReplyMetadata: Bool? = .none,
        excludeReplyUserIDs: [String]? = .none,
        attachmentUrl: String? = .none,
        mediaIDs: [String]? = .none,
        possiblySensitive: Bool? = .none,
        location: TwitterCoordinateV1? = .none,
        placeID: String? = .none,
        displayCoordinates: Bool? = .none,
        trimUser: Bool? = .none,
        enableDMcommands: Bool? = .none,
        failDMcommands: Bool? = .none,
        cardUri: String? = .none
    ) {
        self.status = status
        self.inReplyToStatusID = inReplyToStatusID
        self.autoPopulateReplyMetadata = autoPopulateReplyMetadata
        self.excludeReplyUserIDs = excludeReplyUserIDs
        self.attachmentUrl = attachmentUrl
        self.mediaIDs = mediaIDs
        self.possiblySensitive = possiblySensitive
        self.location = location
        self.placeID = placeID
        self.displayCoordinates = displayCoordinates
        self.trimUser = trimUser
        self.enableDMcommands = enableDMcommands
        self.failDMcommands = failDMcommands
        self.cardUri = cardUri
    }

}
