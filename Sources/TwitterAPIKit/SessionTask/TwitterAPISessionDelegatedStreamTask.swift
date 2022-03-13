import Foundation

private let chunkSeparator = "\r\n".data(using: .utf8)!
public class TwitterAPISessionDelegatedStreamTask: TwitterAPISessionStreamTask, TwitterAPISessionDelegatedTask {

    public var taskIdentifier: Int { return task.taskIdentifier }
    public var currentRequest: URLRequest? { return task.currentRequest }
    public var originalRequest: URLRequest? { return task.originalRequest }
    public var httpResponse: HTTPURLResponse? {
        return task.httpResponse
    }
    private let task: TwitterAPISessionTask
    private var dataBlocks = [(queue: DispatchQueue, block: (TwitterAPIResponse<Data>) -> Void)]()
    private lazy var taskQueue = DispatchQueue(label: "TwitterAPISessionDelegatedStreamTask_\(taskIdentifier)")

    init(task: TwitterAPISessionTask) {
        self.task = task
    }

    @discardableResult
    public func streamResponse(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self {
        dataBlocks.append((queue: queue, block: block))
        return self
    }

    @discardableResult
    public func streamResponse(
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self {
        dataBlocks.append((queue: .main, block: block))
        return self
    }

    public func cancel() {
        task.cancel()
    }

    func append(chunk: Data) {
        taskQueue.async { [weak self] in
            guard let self = self else { return }

            guard let httpResponse = self.httpResponse else {
                self.notify(result: .failure(.responseFailed(reason: .invalidResponse(error: nil))), rateLimit: nil)
                return
            }

            let rateLimit = TwitterRateLimit(header: httpResponse.allHeaderFields)

            guard httpResponse.statusCode < 300 else {

                let error = TwitterAPIErrorResponse(data: chunk)
                self.notify(
                    result: .failure(
                        .responseFailed(
                            reason: .unacceptableStatusCode(
                                statusCode: httpResponse.statusCode,
                                error: error,
                                rateLimit: rateLimit
                            )
                        )), rateLimit: rateLimit)

                return
            }

            for data in chunk.split(separator: chunkSeparator) {
                self.notify(result: .success(data), rateLimit: rateLimit)
            }
        }
    }

    func complete(error: Error?) {
        if let error = error {
            taskQueue.async { [weak self] in
                guard let self = self else { return }
                self.notify(result: .failure(.responseFailed(reason: .invalidResponse(error: error))), rateLimit: nil)
            }
        }
    }

    private func notify(result: Result<Data, TwitterAPIKitError>, rateLimit: TwitterRateLimit?) {
        let response = TwitterAPIResponse(
            request: currentRequest,
            response: httpResponse,
            data: result.success,
            result: result,
            rateLimit: rateLimit
        )

        dataBlocks.forEach { (queue, block) in
            queue.async {
                block(response)
            }
        }
    }
}
