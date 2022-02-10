import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-finalize
open class UploadMediaFinalizeRequestV1: TwitterAPIRequest {

    public let command: String = "FINALIZE"
    public let mediaID: String

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
        return [
            "command": command,
            "media_id": mediaID,
        ]
    }

    public init(mediaID: String) {
        self.mediaID = mediaID
    }
}
