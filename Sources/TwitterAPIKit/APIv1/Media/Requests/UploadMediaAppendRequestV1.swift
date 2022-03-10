import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-append
open class UploadMediaAppendRequestV1: TwitterAPIRequest {

    public let command: String = "APPEND"
    public let mediaID: String

    /// media filename
    public let filename: String

    /// media mime type
    public let mimeType: String
    public let media: Data
    public let segmentIndex: Int

    public var method: HTTPMethod {
        return .post
    }

    public var baseURLType: TwitterBaseURLType {
        return .upload
    }

    public var path: String {
        return "/1.1/media/upload.json"
    }

    public var bodyContentType: BodyContentType {
        return .multipartFormData
    }

    open var parameters: [String: Any] {

        let p: [String: MultipartFormDataPart] = [
            "command": .value(name: "command", value: command),
            "media_id": .value(name: "media_id", value: mediaID),
            "media": .data(name: "media", value: media, filename: filename, mimeType: mimeType),
            "segment_index": .value(name: "segment_index", value: segmentIndex),
        ]

        return p
    }

    public init(
        mediaID: String,
        filename: String,
        mimeType: String,
        media: Data,
        segmentIndex: Int = 0
    ) {
        self.mediaID = mediaID
        self.filename = filename
        self.mimeType = mimeType
        self.media = media
        self.segmentIndex = segmentIndex
    }

    open func segments(maxBytes: Int) -> [UploadMediaAppendRequestV1] {

        var requests = [UploadMediaAppendRequestV1]()
        let totalDataSize = media.count
        var currentSegmentIndex = 0
        repeat {
            currentSegmentIndex = segmentIndex + requests.count
            let start = currentSegmentIndex * maxBytes
            let len = min(totalDataSize - start, maxBytes)
            let req = UploadMediaAppendRequestV1(
                mediaID: mediaID,
                filename: filename,
                mimeType: mimeType,
                media: media.subdata(in: start..<(start + len)),
                segmentIndex: currentSegmentIndex
            )
            requests.append(req)
        } while ((currentSegmentIndex + 1) * maxBytes) < totalDataSize

        return requests
    }
}
