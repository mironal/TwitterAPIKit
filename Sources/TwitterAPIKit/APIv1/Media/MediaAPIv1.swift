import Foundation

public protocol MediaAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/get-media-upload-status
    func getUploadMediaStatus(
        _ request: GetUploadMediaStatusRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-init
    func uploadMediaInit(
        _ request: UploadMediaInitRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-append
    func uploadMediaAppend(
        _ request: UploadMediaAppendRequestV1
    ) -> TwitterAPISessionJSONTask

    /// Utility method for split uploading of large files.
    func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1,
        maxBytes: Int
    ) -> [TwitterAPISessionSpecializedTask<String /* mediaID */>]

    func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1
    ) -> [TwitterAPISessionSpecializedTask<String /* mediaID */>]

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-finalize
    func uploadMediaFinalize(
        _ request: UploadMediaFinalizeRequestV1
    ) -> TwitterAPISessionJSONTask

    /// Upload media utility method.
    /// INIT -> APPEND x n -> FINALIZE -> STATUS x n (If needed)
    func uploadMedia(
        _ parameters: UploadMediaRequestParameters,
        completionHandler: @escaping (
            TwitterAPIResponse<String>
        ) -> Void
    )

    func waitMediaProcessing(
        mediaID: String,
        initialWaitSec: Int,
        completionHandler: @escaping (
            TwitterAPIResponse<TwitterAPIKit.UploadMediaStatusResponse>
        ) -> Void
    )

    func waitMediaProcessing(
        mediaID: String,
        completionHandler: @escaping (
            TwitterAPIResponse<TwitterAPIKit.UploadMediaStatusResponse>
        ) -> Void
    )

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-metadata-create
    func createMediaMetadata(
        _ request: PostMediaMetadataCreateRequestV1
    ) -> TwitterAPISessionDataTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-subtitles-create
    func createSubtitle(
        _ request: PostMediaSubtitlesCreateRequestV1
    ) -> TwitterAPISessionDataTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-subtitles-delete
    func deleteSubtitle(
        _ request: PostMediaSubtitlesDeleteRequestV1
    ) -> TwitterAPISessionDataTask
}

extension TwitterAPIKit.TwitterAPIImplV1: MediaAPIv1 {

    public func getUploadMediaStatus(
        _ request: GetUploadMediaStatusRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func uploadMediaInit(
        _ request: UploadMediaInitRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func uploadMediaAppend(
        _ request: UploadMediaAppendRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func uploadMediaAppendSplitChunks(_ request: UploadMediaAppendRequestV1) -> [TwitterAPISessionSpecializedTask<
        String
    >] {
        return uploadMediaAppendSplitChunks(request, maxBytes: 5_242_880 /* 5MB */)
    }

    func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1, maxBytes: Int
    ) -> [TwitterAPISessionSpecializedTask<String>] {

        // Split media data

        let totalDataSize = request.media.count

        var tasks = [TwitterAPISessionSpecializedTask<String>]()

        var nextRequest = request
        repeat {
            let start = nextRequest.segmentIndex * maxBytes
            let len = min(totalDataSize - nextRequest.segmentIndex * maxBytes, maxBytes)

            let task = uploadMediaAppend(nextRequest.subdata(in: start..<(start + len)))
                .specialized { _ in
                    return request.mediaID
                }

            tasks.append(task)

            nextRequest = nextRequest.nextSegment()
        } while (nextRequest.segmentIndex * maxBytes) < totalDataSize

        return tasks
    }

    public func uploadMediaFinalize(
        _ request: UploadMediaFinalizeRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func uploadMedia(
        _ parameters: UploadMediaRequestParameters,
        completionHandler: @escaping (
            TwitterAPIResponse<String>
        ) -> Void
    ) {
        uploadMediaInit(
            .init(
                totalBytes: parameters.media.count,
                mediaType: parameters.mediaType,
                mediaCategory: parameters.mediaCategory,
                additionalOwners: parameters.additionalOwners
            )
        ).responseDecodable(
            type: TwitterAPIKit.UploadMediaInitResponse.self,
            queue: .processQueue
        ) { [weak self] response in

            guard let self = self else { return }

            let mediaID: String
            do {
                mediaID = try response.result.get().mediaID
            } catch {
                completionHandler(response.map { $0.mediaID })
                return
            }

            self.uploadMediaAppendSplitChunks(
                .init(
                    mediaID: mediaID,
                    filename: parameters.filename,
                    mimeType: parameters.mediaType,
                    media: parameters.media,
                    segmentIndex: 0
                )
            ).responseObject(queue: .processQueue) { [weak self] responses in

                guard let self = self else { return }

                if let error = responses.first(where: { $0.isError }) {
                    completionHandler(error)
                    return
                }

                self.uploadMediaFinalize(.init(mediaID: mediaID))
                    .responseDecodable(type: TwitterAPIKit.UploadMediaFinalizeResponse.self, queue: .processQueue) {
                        [weak self] response in
                        guard let self = self else { return }

                        var finalizeResult: TwitterAPIKit.UploadMediaFinalizeResponse
                        do {
                            finalizeResult = try response.result.get()
                        } catch {
                            completionHandler(response.map { $0.mediaID })
                            return
                        }

                        guard let processingInfo = finalizeResult.processingInfo else {
                            completionHandler(response.map { $0.mediaID })
                            return
                        }

                        self.waitMediaProcessing(
                            mediaID: mediaID,
                            initialWaitSec: processingInfo.checkAfterSecs ?? 0
                        ) { response in
                            completionHandler(response.map { $0.mediaID })
                        }
                    }
            }
        }
    }

    public func waitMediaProcessing(
        mediaID: String,
        initialWaitSec: Int,
        completionHandler: @escaping (
            TwitterAPIResponse<TwitterAPIKit.UploadMediaStatusResponse>
        ) -> Void
    ) {

        DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + .seconds(initialWaitSec)) { [weak self] in
            guard let self = self else { return }
            self.waitMediaProcessing(mediaID: mediaID, completionHandler: completionHandler)
        }
    }

    public func waitMediaProcessing(
        mediaID: String,
        completionHandler: @escaping (
            TwitterAPIResponse<TwitterAPIKit.UploadMediaStatusResponse>
        ) -> Void
    ) {
        _ = getUploadMediaStatus(.init(mediaID: mediaID))
            .responseDecodable(type: TwitterAPIKit.UploadMediaStatusResponse.self, queue: .processQueue) {
                [weak self] response in
                guard let self = self else { return }

                do {
                    let success = try response.result.get()

                    switch success.state {
                    case let .pending(checkAfterSecs: sec),
                        let .inProgress(checkAfterSecs: sec, progressPercent: _):

                        self.waitMediaProcessing(
                            mediaID: mediaID,
                            initialWaitSec: sec,
                            completionHandler: completionHandler
                        )

                    case .succeeded:
                        completionHandler(response)
                    case let .failed(error: error):
                        throw TwitterAPIKitError.uploadMediaFailed(reason: .processingFailed(error: error))
                    case .unknown:
                        throw TwitterAPIKitError.unkonwn(
                            error: NSError(domain: "TwitterAPIKit", code: 0, userInfo: [:]))
                    }
                } catch let error as TwitterAPIKitError {
                    completionHandler(
                        response.mapError { _ in return error }
                    )
                    return
                } catch let error {
                    completionHandler(
                        response.mapError { _ in return TwitterAPIKitError.unkonwn(error: error) }
                    )
                }
            }
    }

    func createMediaMetadata(_ request: PostMediaMetadataCreateRequestV1) -> TwitterAPISessionDataTask {
        return session.send(request)
    }

    func createSubtitle(_ request: PostMediaSubtitlesCreateRequestV1) -> TwitterAPISessionDataTask {
        return session.send(request)
    }

    func deleteSubtitle(_ request: PostMediaSubtitlesDeleteRequestV1) -> TwitterAPISessionDataTask {
        return session.send(request)
    }
}
