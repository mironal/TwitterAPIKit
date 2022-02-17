import Foundation

public typealias TwitterAPISuccessReponse = (data: Data, rateLimit: TwitterRateLimit, response: HTTPURLResponse)

public typealias TwitterAPISerializedSuccessResponse = (
    data: Any, rateLimit: TwitterRateLimit, response: HTTPURLResponse
)

public typealias TwitterAPIDecodedSuccessResponse<D: Decodable> = (
    data: D, rateLimit: TwitterRateLimit, response: HTTPURLResponse
)

public protocol TwitterAPISessionResponse: TwitterAPISessionTask {

    func responseData(
        queue: DispatchQueue,
        _ block: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> Self

    func responseObject(
        queue: DispatchQueue,
        _ block: @escaping (Result<TwitterAPISerializedSuccessResponse, TwitterAPIKitError>) -> Void
    ) -> Self

    func responseDecodable<T: Decodable>(
        type: T.Type,
        queue: DispatchQueue,
        _ block: @escaping (Result<TwitterAPIDecodedSuccessResponse<T>, TwitterAPIKitError>) -> Void
    ) -> Self
}

public struct TwitterAPIFailedResponse: TwitterAPISessionResponse {

    public let error: TwitterAPIKitError

    public init(_ error: Error) {

        switch error {
        case let error as TwitterAPIKitError:
            self.error = error
        default:
            self.error = .unkonwn(error: error)
        }

    }
    public init(error: TwitterAPIKitError) {
        self.error = error
    }

    public var taskIdentifier: Int {
        return 0
    }

    public var currentRequest: URLRequest? {
        return nil
    }

    public var originalRequest: URLRequest? {
        return nil
    }

    public var response: HTTPURLResponse? {
        return nil
    }

    public func responseData(
        queue: DispatchQueue, _ block: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPIFailedResponse {
        queue.async {
            block(.failure(error))
        }
        return self
    }

    public func responseObject(
        queue: DispatchQueue,
        _ block: @escaping (Result<TwitterAPISerializedSuccessResponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPIFailedResponse {
        queue.async {
            block(.failure(error))
        }
        return self
    }

    public func responseDecodable<T>(
        type: T.Type, queue: DispatchQueue,
        _ block: @escaping (Result<TwitterAPIDecodedSuccessResponse<T>, TwitterAPIKitError>) -> Void
    ) -> TwitterAPIFailedResponse where T: Decodable {
        queue.async {
            block(.failure(error))
        }
        return self
    }

    public func cancel() {}
}

public class TwitterAPISessionDelegatedResponse: TwitterAPISessionResponse {

    public var taskIdentifier: Int {
        return task.taskIdentifier
    }

    public var currentRequest: URLRequest? {
        return task.currentRequest
    }

    public var originalRequest: URLRequest? {
        return task.originalRequest
    }

    public var response: HTTPURLResponse? {
        return task.response as? HTTPURLResponse
    }

    public private(set) var error: Error?
    public var data: Data? {
        guard completed else { return nil }
        return dataChunk
    }
    public private(set) var completed = false

    let task: URLSessionTask

    private let taskQueue: DispatchQueue
    private var dataChunk: Data = Data()

    public init(task: URLSessionTask) {
        self.task = task

        // Serial queue
        taskQueue = DispatchQueue(label: "TwitterAPIKit.task.\(task.taskIdentifier)")
        taskQueue.suspend()
    }

    func append(chunk: Data) {
        dataChunk.append(chunk)
    }

    func complete(error: Error?) {
        self.error = error
        self.completed = true
        taskQueue.resume()
    }

    private func parseResponse() -> Result<TwitterAPISuccessReponse, TwitterAPIKitError> {

        guard completed, let data = self.data else {
            fatalError("Request not completed yet.")
        }

        guard error == nil, let httpResponse = response else {
            return .failure(.responseFailed(reason: .invalidResponse(error: error, response: response)))
        }

        let rateLimit = TwitterRateLimit(header: httpResponse.allHeaderFields)

        guard 200..<300 ~= httpResponse.statusCode else {
            return .failure(
                .responseFailed(
                    reason: .unacceptableStatusCode(
                        statusCode: httpResponse.statusCode,
                        error: TwitterAPIErrorResponse(data: data),
                        rateLimit: rateLimit
                    )
                )
            )
        }

        return .success((data, rateLimit, httpResponse))
    }

    public func responseData(
        queue: DispatchQueue, _ block: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> Self {
        taskQueue.async { [weak self] in
            guard let self = self else { return }

            let result = self.parseResponse()

            queue.async {
                block(result)
            }
        }
        return self
    }

    public func responseObject(
        queue: DispatchQueue,
        _ block: @escaping (Result<TwitterAPISerializedSuccessResponse, TwitterAPIKitError>) -> Void
    ) -> Self {
        taskQueue.async { [weak self] in
            guard let self = self else { return }
            let result = self.parseResponse().serialize()
            queue.async {
                block(result)
            }
        }
        return self
    }

    public func responseDecodable<T>(
        type: T.Type, queue: DispatchQueue,
        _ block: @escaping (Result<TwitterAPIDecodedSuccessResponse<T>, TwitterAPIKitError>) -> Void
    ) -> Self where T: Decodable {

        taskQueue.async { [weak self] in
            guard let self = self else { return }
            let result = self.parseResponse().decode(type)
            queue.async {
                block(result)
            }
        }
        return self
    }

    public func cancel() {
        task.cancel()
    }
}
