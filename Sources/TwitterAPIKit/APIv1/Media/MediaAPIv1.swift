import Foundation

extension DispatchQueue {
    static var processQueue: DispatchQueue {
        .global(qos: .default)
    }
}

public protocol MediaAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/get-media-upload-status
    @discardableResult
    func getUploadMediaStatus(
        _ request: GetUploadMediaStatusRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-init
    @discardableResult
    func uploadMediaInit(
        _ request: UploadMediaInitRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-append
    @discardableResult
    func uploadMediaAppend(
        _ request: UploadMediaAppendRequestV1
    ) -> TwitterAPISessionJSONTask

    /// Utility method for split uploading of large files.
    func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1,
        maxBytes: Int,
        completionHandler: @escaping (Result<[TwitterAPIResponse<Data>], TwitterAPIKitError>) -> Void
    )

    func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1,
        completionHandler: @escaping (Result<[TwitterAPIResponse<Data>], TwitterAPIKitError>) -> Void
    )

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-finalize
    @discardableResult
    func uploadMediaFinalize(
        _ request: UploadMediaFinalizeRequestV1
    ) -> TwitterAPISessionJSONTask

    /// Upload media utility method.
    /// INIT -> APPEND x n -> FINALIZE -> STATUS x n (If needed)
    func uploadMedia(
        _ parameters: UploadMediaRequestParameters,
        completionHandler: @escaping (
            Result<String /* MediaID */, TwitterAPIKitError>
        ) -> Void
    )

    func waitMediaProcessing(
        mediaID: String,
        initialWaitSec: Int,
        completionHandler: @escaping (
            Result<TwitterAPIKit.UploadMediaStatusResponse, TwitterAPIKitError>
        ) -> Void
    )

    func waitMediaProcessing(
        mediaID: String,
        completionHandler: @escaping (
            Result<TwitterAPIKit.UploadMediaStatusResponse, TwitterAPIKitError>
        ) -> Void
    )
}

extension TwitterAPIKit.TwitterAPIImplV1: MediaAPIv1 {

    public func getUploadMediaStatus(
        _ request: GetUploadMediaStatusRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    @discardableResult
    public func uploadMediaInit(
        _ request: UploadMediaInitRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    @discardableResult
    public func uploadMediaAppend(
        _ request: UploadMediaAppendRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1,
        completionHandler: @escaping (Result<[TwitterAPIResponse<Data>], TwitterAPIKitError>) -> Void
    ) {
        uploadMediaAppendSplitChunks(request, maxBytes: 5_242_880 /* 5MB */, completionHandler: completionHandler)
    }

    func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1,
        maxBytes: Int,
        completionHandler: @escaping (Result<[TwitterAPIResponse<Data>], TwitterAPIKitError>) -> Void
    ) {

        // Split media data

        let totalDataSize = request.media.count
        let group = DispatchGroup()

        var responses = [TwitterAPIResponse<Data>]()

        var nextRequest = request
        repeat {
            let start = nextRequest.segmentIndex * maxBytes
            let len = min(totalDataSize - nextRequest.segmentIndex * maxBytes, maxBytes)
            group.enter()

            uploadMediaAppend(nextRequest.subdata(in: start..<(start + len)))
                .responseData(queue: .processQueue) { response in
                    defer { group.leave() }
                    responses.append(response)
                }

            nextRequest = nextRequest.nextSegment()
        } while (nextRequest.segmentIndex * maxBytes) < totalDataSize

        group.notify(queue: .main) {
            let firstError = responses.first { $0.isError }?.error

            if let error = firstError {
                completionHandler(.failure(error))
                return
            }
            completionHandler(.success(responses))
        }
    }

    public func uploadMediaFinalize(
        _ request: UploadMediaFinalizeRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func uploadMedia(
        _ parameters: UploadMediaRequestParameters,
        completionHandler: @escaping (
            Result<String /* MediaID */, TwitterAPIKitError>
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
            } catch let error {
                completionHandler(.failure(TwitterAPIKitError(error: error)))
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
            ) { [weak self] response in
                guard let self = self else { return }

                if let error = response.error {
                    completionHandler(.failure(error))
                    return
                }

                _ = self.uploadMediaFinalize(.init(mediaID: mediaID))
                    .responseDecodable(type: TwitterAPIKit.UploadMediaFinalizeResponse.self, queue: .processQueue) {
                        [weak self] response in
                        guard let self = self else { return }

                        var finalizeResult: TwitterAPIKit.UploadMediaFinalizeResponse
                        do {
                            finalizeResult = try response.result.get()
                        } catch let error {
                            completionHandler(.failure(TwitterAPIKitError(error: error)))
                            return
                        }

                        guard let processingInfo = finalizeResult.processingInfo else {
                            completionHandler(.success(mediaID))
                            return
                        }

                        self.waitMediaProcessing(mediaID: mediaID, initialWaitSec: processingInfo.checkAfterSecs ?? 0) {
                            result in
                            completionHandler(result.map { $0.mediaID })
                        }
                    }
            }
        }
    }

    public func waitMediaProcessing(
        mediaID: String,
        initialWaitSec: Int,
        completionHandler: @escaping (
            Result<TwitterAPIKit.UploadMediaStatusResponse, TwitterAPIKitError>
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
            Result<TwitterAPIKit.UploadMediaStatusResponse, TwitterAPIKitError>
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
                            mediaID: mediaID, initialWaitSec: sec, completionHandler: completionHandler)

                    case .succeeded:
                        completionHandler(.success(success))
                    case let .failed(error: error):
                        completionHandler(.failure(.uploadMediaFailed(reason: .processingFailed(error: error))))
                    case .unknown:
                        completionHandler(
                            .failure(.unkonwn(error: NSError(domain: "TwitterAPIKit", code: 0, userInfo: [:]))))
                    }
                } catch let error as TwitterAPIKitError {
                    completionHandler(.failure(error))
                    return

                } catch let error {
                    completionHandler(.failure(.unkonwn(error: error)))
                    return
                }
            }
    }
}
