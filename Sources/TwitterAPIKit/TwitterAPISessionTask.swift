import Foundation

// The Twitter API basically returns a JSON response, but some APIs, such as the authentication API, return a special response.

public protocol TwitterAPISessionDataTask {
    var taskIdentifier: Int { get }
    var currentRequest: URLRequest? { get }
    var originalRequest: URLRequest? { get }

    func cancel()

    @discardableResult
    func responseData(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self
}

extension TwitterAPISessionDataTask {
    func specialized<NewSuccess>(_ transform: @escaping (Data) throws -> NewSuccess)
        -> TwitterAPISessionSpecializedTask<NewSuccess>
    {
        return TwitterAPISessionSpecializedTask(task: self, transform: transform)
    }
}

public protocol TwitterAPISessionJSONTask: TwitterAPISessionDataTask {

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

extension TwitterAPISessionJSONTask {
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

public struct TwitterAPIFailedTask: TwitterAPISessionJSONTask {

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
    ) -> TwitterAPIFailedTask {
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
    ) -> TwitterAPIFailedTask {
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
    ) -> TwitterAPIFailedTask where T: Decodable {
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

public class TwitterAPISessionDelegatedTask: TwitterAPISessionJSONTask {

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
            return .failure(.responseFailed(reason: .invalidResponse(error: error)))
        }

        let rateLimit = TwitterRateLimit(header: httpResponse.allHeaderFields)

        guard 200..<300 ~= httpResponse.statusCode else {
            return .failure(
                .responseFailed(
                    reason: .unacceptableStatusCode(
                        statusCode: httpResponse.statusCode,
                        error: TwitterAPIErrorResponse(data: data)
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

protocol TwitterAPISessionSpecializedTask_: TwitterAPISessionDataTask {
    associatedtype Success
    @discardableResult
    func responseObject(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Success>) -> Void
    ) -> TwitterAPISessionSpecializedTask<Success>
}

public struct TwitterAPISessionSpecializedTask<Success>: TwitterAPISessionSpecializedTask_ {

    public var taskIdentifier: Int {
        return innerTask.taskIdentifier
    }
    public var currentRequest: URLRequest? {
        return innerTask.currentRequest
    }
    public var originalRequest: URLRequest? {
        return innerTask.originalRequest
    }

    private let innerTask: TwitterAPISessionDataTask
    private let transform: (Data) throws -> Success
    init(
        task: TwitterAPISessionDataTask,
        transform: @escaping (Data) throws -> Success
    ) {
        self.innerTask = task
        self.transform = transform
    }

    @discardableResult
    public func responseObject(
        queue: DispatchQueue = .main,
        _ block: @escaping (TwitterAPIResponse<Success>) -> Void
    ) -> TwitterAPISessionSpecializedTask<Success> {
        innerTask.responseData(queue: queue) { response in
            let success = response.tryMap(transform)
            block(success)
        }
        return self
    }

    @discardableResult
    public func responseData(
        queue: DispatchQueue = .main,
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> TwitterAPISessionSpecializedTask<Success> {
        innerTask.responseData(queue: queue, block)
        return self
    }

    public func cancel() {
        innerTask.cancel()
    }
}

extension Array where Element: TwitterAPISessionSpecializedTask_ {

    func responseObject(
        queue: DispatchQueue = .main, _ block: @escaping ([TwitterAPIResponse<Element.Success>]) -> Void
    ) {

        let group = DispatchGroup()

        var responses = [TwitterAPIResponse<Element.Success>]()

        self.forEach { task in
            group.enter()
            task.responseObject(queue: .processQueue) {
                responses.append($0)
                group.leave()
            }
        }

        group.notify(queue: queue) {
            block(responses)
        }
    }
}
