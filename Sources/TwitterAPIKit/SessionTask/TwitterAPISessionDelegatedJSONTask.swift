import Foundation

protocol TwitterAPISessionDelegatedJSONTaskDelegate: AnyObject {
    func didFinishQueueInJsonTask(task: TwitterAPISessionDelegatedJSONTask)
}

public class TwitterAPISessionDelegatedJSONTask: TwitterAPISessionJSONTask, TwitterAPISessionDelegatedTask {

    public var taskIdentifier: Int {
        return task.taskIdentifier
    }

    public var currentRequest: URLRequest? {
        return task.currentRequest
    }

    public var originalRequest: URLRequest? {
        return task.originalRequest
    }

    public var httpResponse: HTTPURLResponse? {
        return task.httpResponse
    }

    weak var delegate: TwitterAPISessionDelegatedJSONTaskDelegate?

    public private(set) var error: Error?
    public var data: Data? {
        guard completed else { return nil }
        return dataChunk
    }
    public private(set) var completed = false

    let task: TwitterAPISessionTask

    private let taskQueue: DispatchQueue
    private var dataChunk: Data = Data()
    private let group = DispatchGroup()

    public init(task: TwitterAPISessionTask) {
        self.task = task

        // Serial queue
        taskQueue = DispatchQueue(label: "TwitterAPIClient.task.\(task.taskIdentifier)")
        taskQueue.suspend()
    }

    deinit {
        // EXC_BAD_INSTRUCTION will occur if the Dispatch Queue is released while suspended.
        if !completed {
            taskQueue.resume()
        }
    }

    func append(chunk: Data) {
        dataChunk.append(chunk)
    }

    func complete(error: Error?) {
        self.error = error
        self.completed = true

        group.notify(queue: taskQueue) { [weak self] in
            guard let self = self else { return }
            self.delegate?.didFinishQueueInJsonTask(task: self)
        }
        taskQueue.resume()
    }

    private func getResponse() -> TwitterAPIResponse<Data> {

        guard completed, let data = self.data else {
            fatalError("Request not completed yet.")
        }

        guard error == nil, let httpResponse = httpResponse else {
            return TwitterAPIResponse(
                request: currentRequest,
                response: httpResponse,
                data: data,
                result: .failure(.responseFailed(reason: .invalidResponse(error: error))),
                rateLimit: nil
            )
        }

        let rateLimit = TwitterRateLimit(header: httpResponse.allHeaderFields)

        guard 200..<300 ~= httpResponse.statusCode else {

            return TwitterAPIResponse(
                request: currentRequest,
                response: httpResponse,
                data: data,
                result: .failure(
                    .responseFailed(
                        reason: .unacceptableStatusCode(
                            statusCode: httpResponse.statusCode, error: .init(data: data), rateLimit: rateLimit))),
                rateLimit: rateLimit
            )
        }

        return TwitterAPIResponse(
            request: currentRequest,
            response: httpResponse,
            data: data,
            result: .success(data),
            rateLimit: rateLimit
        )
    }

    private func registerResponseBlock<T>(
        queue: DispatchQueue,
        flatMap transform: @escaping (Data) -> Result<T, TwitterAPIKitError>,
        response block: @escaping ((TwitterAPIResponse<T>) -> Void)
    ) -> Self {

        group.enter()
        taskQueue.async { [weak self] in
            guard let self = self else { return }

            let response = self.getResponse().flatMap(transform)

            queue.async { [weak self] in
                guard let self = self else { return }
                block(response)
                self.group.leave()
            }
        }

        return self
    }

    public func responseData(queue: DispatchQueue, _ block: @escaping (TwitterAPIResponse<Data>) -> Void) -> Self {
        return registerResponseBlock(queue: queue, flatMap: { .success($0) }, response: block)
    }

    public func responseData(_ block: @escaping (TwitterAPIResponse<Data>) -> Void) -> Self {
        return responseData(queue: .main, block)
    }

    public func responseObject(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Any>) -> Void
    ) -> Self {
        return registerResponseBlock(
            queue: queue,
            flatMap: { $0.serialize() },
            response: block
        )
    }

    public func responseObject(_ block: @escaping (TwitterAPIResponse<Any>) -> Void) -> Self {
        return responseObject(queue: .main, block)
    }

    public func responseDecodable<T>(
        type: T.Type,
        decoder: JSONDecoder = TwitterAPIClient.defaultJSONDecoder,
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self where T: Decodable {
        return registerResponseBlock(
            queue: queue,
            flatMap: { $0.decode(type, decoder: decoder) },
            response: block
        )
    }

    public func responseDecodable<T>(
        type: T.Type,
        decoder: JSONDecoder,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self where T: Decodable {
        return responseDecodable(
            type: type,
            decoder: decoder,
            queue: .main,
            block
        )
    }

    public func responseDecodable<T>(
        type: T.Type,
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self where T: Decodable {
        return responseDecodable(
            type: type,
            decoder: TwitterAPIClient.defaultJSONDecoder,
            queue: queue,
            block
        )
    }

    public func responseDecodable<T>(
        type: T.Type,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self where T: Decodable {
        return responseDecodable(
            type: type,
            decoder: TwitterAPIClient.defaultJSONDecoder,
            queue: .main,
            block
        )
    }

    public func cancel() {
        task.cancel()
    }
}
