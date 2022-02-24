import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-metadata-create
open class PostMediaMetadataCreateRequestV1: TwitterAPIRequest {

    public let mediaID: String
    public let altText: String

    public var method: HTTPMethod {
        return .post
    }

    public var baseURLType: TwitterBaseURLType {
        return .upload
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    public var path: String {
        return "/1.1/media/metadata/create.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()

        p["media_id"] = mediaID
        p["alt_text"] = ["text": altText]

        return p
    }

    public init(
        mediaID: String,
        altText: String
    ) {
        self.mediaID = mediaID
        self.altText = altText
    }
}
