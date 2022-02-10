import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-init
open class UploadMediaInitRequestV1: TwitterAPIRequest {

    public let command: String = "INIT"
    public let totalBytes: Int
    public let mediaType: String
    public let mediaCategory: String?
    public let additionalOwners: [String]?

    public var method: HTTPMethod {
        return .post
    }

    public var baseURLType: TwitterBaseURLType {
        return .upload
    }

    public var path: String {
        return "/1.1/media/upload.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["command"] = command
        p["total_bytes"] = totalBytes
        p["media_type"] = mediaType
        mediaCategory.map { p["media_category"] = $0 }
        additionalOwners.map { p["additional_owners"] = $0.joined(separator: ",") }
        return p
    }

    public init(
        totalBytes: Int,
        mediaType: String,
        mediaCategory: String? = .none,
        additionalOwners: [String]? = .none
    ) {
        self.totalBytes = totalBytes
        self.mediaType = mediaType
        self.mediaCategory = mediaCategory
        self.additionalOwners = additionalOwners
    }
}
