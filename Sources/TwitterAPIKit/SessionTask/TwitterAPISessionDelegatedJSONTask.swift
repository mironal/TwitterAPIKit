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

    public var response: HTTPURLResponse? {
        return task.response as? HTTPURLResponse
    }

    weak var delegate: TwitterAPISessionDelegatedJSONTaskDelegate?

    public private(set) var error: Error?
    public var data: Data? {
        guard completed else { return nil }
        return dataChunk
    }
    public private(set) var completed = false

    let task: URLSessionTask

    private let taskQueue: DispatchQueue
    private var dataChunk: Data = Data()
    let group = DispatchGroup()

    deinit {
        print("deinit")
    }
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

        group.notify(queue: taskQueue) { [weak self] in
            guard let self = self else { return }
            self.delegate?.didFinishQueueInJsonTask(task: self)
        }
        taskQueue.resume()
    }

    private func getResult() -> Result<(data: Data, rateLimit: TwitterRateLimit), TwitterAPIKitError> {

        guard completed, let data = self.data else {
            fatalError("Request not completed yet.")
        }

        guard error == nil, let httpResponse = response else {
            return .failure(.responseFailed(reason: .invalidResponse(error: error)))
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

        return .success((data: data, rateLimit: rateLimit))
    }

    private func registerResponseBlock<T>(
        queue: DispatchQueue,
        map mapResult: @escaping (Result<Data, TwitterAPIKitError>) -> Result<T, TwitterAPIKitError>,
        response block: @escaping ((TwitterAPIResponse<T>) -> Void)
    ) -> Self {

        group.enter()
        taskQueue.async { [weak self] in
            guard let self = self else { return }
            let result = self.getResult()

            let response = TwitterAPIResponse(
                request: self.currentRequest,
                response: self.response,
                data: self.data,
                result: mapResult(result.map { $0.data }),
                rateLimit: result.success?.rateLimit
            )

            queue.async { [weak self] in
                guard let self = self else { return }
                block(response)
                self.group.leave()
            }
        }

        return self
    }

    public func responseData(queue: DispatchQueue, _ block: @escaping (TwitterAPIResponse<Data>) -> Void) -> Self {
        return registerResponseBlock(queue: queue, map: { $0 }, response: block)
    }

    public func responseObject(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Any>) -> Void
    ) -> Self {
        return registerResponseBlock(queue: queue, map: { $0.serialize() }, response: block)
    }

    public func responseDecodable<T>(
        type: T.Type,
        decoder: JSONDecoder = TwitterAPIKit.defaultJSONDecoder,
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self where T: Decodable {
        return registerResponseBlock(queue: queue, map: { $0.decode(type, decodar: decoder) }, response: block)
    }

    public func cancel() {
        task.cancel()
    }
}
