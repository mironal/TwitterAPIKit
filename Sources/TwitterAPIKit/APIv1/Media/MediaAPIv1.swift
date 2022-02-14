import Foundation

public protocol MediaAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/get-media-upload-status
    @discardableResult
    func getUploadMediaStatus(
        _ request: GetUploadMediaStatusRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-init
    @discardableResult
    func uploadMediaInit(
        _ request: UploadMediaInitRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-append
    @discardableResult
    func uploadMediaAppend(
        _ request: UploadMediaAppendRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

    /// Utility method for split uploading of large files.
    @discardableResult
    func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1,
        maxBytes: Int,
        completionHandler: @escaping (Result<[TwitterAPISuccessReponse], TwitterAPIKitError>) ->
            Void
    ) -> [TwitterAPISessionTask]

    @discardableResult
    func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1,
        completionHandler: @escaping (Result<[TwitterAPISuccessReponse], TwitterAPIKitError>) ->
            Void
    ) -> [TwitterAPISessionTask]

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-finalize
    @discardableResult
    func uploadMediaFinalize(
        _ request: UploadMediaFinalizeRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

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

extension TwitterAPIKit: MediaAPIv1 {

    public func getUploadMediaStatus(
        _ request: GetUploadMediaStatusRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    @discardableResult
    public func uploadMediaInit(
        _ request: UploadMediaInitRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    @discardableResult
    public func uploadMediaAppend(
        _ request: UploadMediaAppendRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    @discardableResult
    public func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1,
        completionHandler: @escaping (Result<[TwitterAPISuccessReponse], TwitterAPIKitError>) -> Void
    ) -> [TwitterAPISessionTask] {
        return uploadMediaAppendSplitChunks(
            request, maxBytes: 5_242_880 /* 5MB */, completionHandler: completionHandler
        )
    }

    @discardableResult
    public func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1,
        maxBytes: Int,
        completionHandler: @escaping (Result<[TwitterAPISuccessReponse], TwitterAPIKitError>) ->
            Void
    ) -> [TwitterAPISessionTask] {

        // Split media data

        let totalDataSize = request.media.count
        let group = DispatchGroup()

        var tasks = [TwitterAPISessionTask]()
        var errors = [TwitterAPIKitError]()
        var responses = [TwitterAPISuccessReponse]()

        var nextRequest = request
        repeat {
            let start = nextRequest.segmentIndex * maxBytes
            let len = min(totalDataSize - nextRequest.segmentIndex * maxBytes, maxBytes)
            group.enter()

            let task = uploadMediaAppend(nextRequest.subdata(in: start..<(start + len))) { result in
                defer { group.leave() }

                switch result {
                case .success(let response):
                    responses.append(response)
                case .failure(let error):
                    errors.append(error)
                }
            }

            tasks.append(task)
            nextRequest = nextRequest.nextSegment()
        } while (nextRequest.segmentIndex * maxBytes) < totalDataSize

        group.notify(queue: .main) {
            guard errors.isEmpty else {
                completionHandler(.failure(errors[0]))
                return
            }
            completionHandler(.success(responses))
        }

        return tasks
    }

    public func uploadMediaFinalize(
        _ request: UploadMediaFinalizeRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
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
        ) { [weak self] result in

            guard let self = self else { return }

            let initResult: (data: UploadMediaInitResponse, rateLimit: TwitterRateLimit, response: HTTPURLResponse)
            do {
                initResult = try result.decode(UploadMediaInitResponse.self).get()
            } catch let error as TwitterAPIKitError {
                completionHandler(.failure(error))
                return
            } catch let error {
                completionHandler(.failure(.unkonwn(error: error)))
                return
            }

            let mediaID = initResult.data.mediaID

            self.uploadMediaAppendSplitChunks(
                .init(
                    mediaID: mediaID,
                    filename: parameters.filename,
                    mimeType: parameters.mediaType,
                    media: parameters.media,
                    segmentIndex: 0
                )
            ) { [weak self] _ in

                guard let self = self else { return }
                _ = self.uploadMediaFinalize(.init(mediaID: mediaID)) { [weak self] result in
                    guard let self = self else { return }

                    var finalizeResult:
                        (data: UploadMediaFinalizeResponse, rateLimit: TwitterRateLimit, response: HTTPURLResponse)
                    do {
                        finalizeResult = try result.decode(UploadMediaFinalizeResponse.self).get()
                    } catch let error as TwitterAPIKitError {
                        completionHandler(.failure(error))
                        return
                    } catch {
                        completionHandler(.failure(.unkonwn(error: error)))
                        return
                    }

                    guard let processingInfo = finalizeResult.data.processingInfo else {
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
            Result<UploadMediaStatusResponse, TwitterAPIKitError>
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
            Result<UploadMediaStatusResponse, TwitterAPIKitError>
        ) -> Void
    ) {

        _ = getUploadMediaStatus(.init(mediaID: mediaID)) { [weak self] result in
            guard let self = self else { return }

            do {
                let success = try result.decode(UploadMediaStatusResponse.self).get()

                switch success.data.state {
                case let .pending(checkAfterSecs: sec),
                    let .inProgress(checkAfterSecs: sec, progressPercent: _):

                    self.waitMediaProcessing(
                        mediaID: mediaID, initialWaitSec: sec, completionHandler: completionHandler)

                case .succeeded:
                    completionHandler(.success(success.data))
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
