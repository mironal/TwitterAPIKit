import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-subtitles-create
open class PostMediaSubtitlesCreateRequestV1: TwitterAPIRequest {

    public struct Subtitle {
        public let mediaID: String
        /// The language code should be a BCP47 code (e.g. 'en", "sp")
        public let languageCode: String
        public let displayName: String

        public init(
            mediaID: String,
            languageCode: String,
            displayName: String
        ) {
            self.mediaID = mediaID
            self.languageCode = languageCode
            self.displayName = displayName
        }
    }

    public let mediaID: String
    public let mediaCategory: String
    public let subtitles: [Subtitle]

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
        return "/1.1/media/subtitles/create.json"
    }

    open var parameters: [String: Any] {

        var p = [String: Any]()
        p["media_id"] = mediaID
        p["media_category"] = mediaCategory
        p["subtitle_info"] = [
            "subtitles": subtitles.map {
                return [
                    "media_id": $0.mediaID,
                    "language_code": $0.languageCode,
                    "display_name": $0.displayName,
                ]
            }
        ]
        return p
    }

    public init(
        mediaID: String,
        mediaCategory: String,
        subtitles: [Subtitle]
    ) {
        self.mediaID = mediaID
        self.mediaCategory = mediaCategory
        self.subtitles = subtitles
    }
}
