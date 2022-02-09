import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-statuses-update
open class PostUpdateStatusRequestV1: TwitterAPIRequest {

    // TODO: Other parameters

    public let status: String
    public let mediaIds: [String]

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/statuses/update.json"
    }

    open var parameters: [String: Any]? {
        var p = [String: Any]()
        p["status"] = status

        if !mediaIds.isEmpty {
            p["media_ids"] = mediaIds.joined(separator: ",")
        }

        return p
    }

    public init(
        status: String,
        mediaIds: [String]? = .none
    ) {
        self.status = status
        self.mediaIds = mediaIds ?? []
    }
}
