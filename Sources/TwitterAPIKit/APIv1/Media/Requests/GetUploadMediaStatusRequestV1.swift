import Foundation

open class GetUploadMediaStatusRequestV1: TwitterAPIRequest {

    public let command: String = "STATUS"
    public let mediaID: String

    public var method: HTTPMethod {
        return .get
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
