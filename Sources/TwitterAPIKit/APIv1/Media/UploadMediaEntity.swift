import Foundation

public struct UploadMediaParameters {
    public let media: Data
    public let mediaType: String
    public let filename: String
    public let mediaCategory: String?
    public let additionalOwners: [String]?

    /// filename can be any value. ex) hoge.mp4
    public init(
        media: Data,
        mediaType: String,
        filename: String,
        mediaCategory: String? = .none,
        additionalOwners: [String]? = .none
    ) {
        self.media = media
        self.mediaType = mediaType
        self.mediaCategory = mediaCategory
        self.additionalOwners = additionalOwners
        self.filename = filename
    }
}

public struct UploadMediaInitResponse: Decodable {
    public let mediaID: String
    public let expiresAfterSecs: Int

    private enum CodingKeys: String, CodingKey {
        case mediaID = "mediaIdString"
        case expiresAfterSecs
    }
}

public struct UploadMediaVideo: Decodable {
    public let videoType: String
}

public struct UploadMediaError: Decodable, Error {
    public let code: Int
    public let name: String
    public let message: String
}

public struct UploadMediaProcessingInfo: Decodable {

    public enum State {
        case pending(checkAfterSecs: Int)
        case inProgress(checkAfterSecs: Int, progressPercent: Int)
        case failed(error: UploadMediaError)
        case succeeded

        case unknown
    }

    public var enumState: State {
        if state == "pending", let checkAfterSecs = checkAfterSecs {
            return .pending(checkAfterSecs: checkAfterSecs)
        }

        if state == "in_progress", let checkAfterSecs = checkAfterSecs, let progressPercent = progressPercent {
            return .inProgress(checkAfterSecs: checkAfterSecs, progressPercent: progressPercent)
        }

        if state == "failed", let error = error {
            return .failed(error: error)
        }

        if state == "succeeded" {
            return .succeeded
        }
        return .unknown
    }

    /// pending -> in_progress -> [failed|succeeded]
    public let state: String
    public let checkAfterSecs: Int?

    /// 0 - 100 %
    public let progressPercent: Int?
    public let error: UploadMediaError?
}

public struct UploadMediaFinalizeResponse: Decodable {

    public let mediaID: String
    public let size: Int
    public let expiresAfterSecs: Int
    public let video: UploadMediaVideo?
    public let processingInfo: UploadMediaProcessingInfo?

    private enum CodingKeys: String, CodingKey {
        case mediaID = "mediaIdString"
        case size, expiresAfterSecs, video, processingInfo
    }
}

public struct UploadMediaStatusResponse: Decodable {

    public var state: UploadMediaProcessingInfo.State {
        return processingInfo.enumState
    }

    public let mediaID: String
    public let expiresAfterSecs: Int?
    public let video: UploadMediaVideo?
    public let processingInfo: UploadMediaProcessingInfo

    private enum CodingKeys: String, CodingKey {
        case mediaID = "mediaIdString"
        case expiresAfterSecs, video, processingInfo
    }
}
