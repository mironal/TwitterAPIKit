import Foundation

public protocol TwitterAPISessionTask {

    var taskIdentifier: Int { get }
    var currentRequest: URLRequest? { get }
    var originalRequest: URLRequest? { get }

    func cancel()
}

public protocol TwitterAPISessionResponse: TwitterAPISessionTask {

    @discardableResult
    func responseData(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self

    @discardableResult
    func responseObject(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Any>) -> Void
    ) -> Self

    @discardableResult
    func responseDecodable<T: Decodable>(
        type: T.Type,
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self
}

extension TwitterAPISessionResponse {
    @discardableResult
    public func responseData(
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self {
        return responseData(queue: .main, block)
    }

    @discardableResult
    public func responseObject(
        _ block: @escaping (TwitterAPIResponse<Any>) -> Void
    ) -> Self {
        return responseObject(queue: .main, block)
    }

    @discardableResult
    public func responseDecodable<T: Decodable>(
        type: T.Type,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self {
        return responseDecodable(type: type, queue: .main, block)
    }
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
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> TwitterAPIFailedResponse {
        queue.async {
            let response = TwitterAPIResponse<Data>(
                request: nil,
                response: nil,
                data: nil,
                result: .failure(error),
                rateLimit: nil)
            block(response)
        }
        return self
    }

    public func responseObject(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Any>) -> Void
    ) -> TwitterAPIFailedResponse {
        queue.async {
            let response = TwitterAPIResponse<Any>(
                request: nil,
                response: nil,
                data: nil,
                result: .failure(error),
                rateLimit: nil)
            block(response)

        }
        return self
    }

    public func responseDecodable<T>(
        type: T.Type, queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> TwitterAPIFailedResponse where T: Decodable {
        queue.async {
            let response = TwitterAPIResponse<T>(
                request: nil,
                response: nil,
                data: nil,
                result: .failure(error),
                rateLimit: nil)
            block(response)

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
    let group = DispatchGroup()

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

    func didComplete(_ block: @escaping () -> Void) {
        group.notify(queue: taskQueue, execute: block)
    }

    private func getResult() -> Result<(data: Data, rateLimit: TwitterRateLimit), TwitterAPIKitError> {

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

        return .success((data: data, rateLimit: rateLimit))
    }

    public func responseData(queue: DispatchQueue, _ block: @escaping (TwitterAPIResponse<Data>) -> Void) -> Self {
        group.enter()
        taskQueue.async { [weak self] in
            guard let self = self else { return }

            let result = self.getResult()
            let response = TwitterAPIResponse(
                request: self.currentRequest,
                response: self.response,
                data: self.data,
                result: result.map { $0.data },
                rateLimit: result.success?.rateLimit
            )

            queue.async { [weak self] in
                block(response)
                self?.group.leave()
            }
        }
        return self
    }

    public func responseObject(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Any>) -> Void
    ) -> Self {
        group.enter()
        taskQueue.async { [weak self] in
            guard let self = self else { return }

            let result = self.getResult()
            let response = TwitterAPIResponse(
                request: self.currentRequest,
                response: self.response,
                data: self.data,
                result: result.map { $0.data }.serialize(),
                rateLimit: result.success?.rateLimit
            )
            queue.async { [weak self] in
                block(response)
                self?.group.leave()
            }
        }
        return self
    }

    public func responseDecodable<T>(
        type: T.Type, queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self where T: Decodable {
        group.enter()
        taskQueue.async { [weak self] in
            guard let self = self else { return }

            let result = self.getResult()
            let response = TwitterAPIResponse(
                request: self.currentRequest,
                response: self.response,
                data: self.data,
                result: result.map { $0.data }.decode(type),
                rateLimit: result.success?.rateLimit
            )
            queue.async { [weak self] in
                block(response)
                self?.group.leave()
            }
        }
        return self
    }

    public func cancel() {
        task.cancel()
    }
}
