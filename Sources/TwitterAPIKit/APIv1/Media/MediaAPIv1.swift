import Foundation

public protocol MediaAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/get-media-upload-status
    @discardableResult
    func getUploadMediaStatus(
        _ request: GetUploadMediaStatusRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-init
    @discardableResult
    func uploadMediaInit(
        _ request: UploadMediaInitRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-append
    @discardableResult
    func uploadMediaAppend(
        _ request: UploadMediaAppendRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

    /// Utility method for split uploading of large files.
    @discardableResult
    func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1,
        maxBytes: Int,
        completionHandler: @escaping (Result<[TwitterAPISuccessReponse], TwitterAPIKitError>) ->
            Void
    ) -> [URLSessionTask]

    @discardableResult
    func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1,
        completionHandler: @escaping (Result<[TwitterAPISuccessReponse], TwitterAPIKitError>) ->
            Void
    ) -> [URLSessionTask]

    /// https://developer.twitter.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload-finalize
    @discardableResult
    func uploadMediaFinalize(
        _ request: UploadMediaFinalizeRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask
}

extension TwitterAPIKit: MediaAPIv1 {

    public func getUploadMediaStatus(
        _ request: GetUploadMediaStatusRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    @discardableResult
    public func uploadMediaInit(
        _ request: UploadMediaInitRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    @discardableResult
    public func uploadMediaAppend(
        _ request: UploadMediaAppendRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    @discardableResult
    public func uploadMediaAppendSplitChunks(
        _ request: UploadMediaAppendRequestV1,
        completionHandler: @escaping (Result<[TwitterAPISuccessReponse], TwitterAPIKitError>) -> Void
    ) -> [URLSessionTask] {
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
    ) -> [URLSessionTask] {

        // Split media data

        let totalDataSize = request.media.count
        let group = DispatchGroup()

        var tasks = [URLSessionTask]()
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
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }
}
