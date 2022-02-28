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
    private var dataBlocks = [(TwitterAPIResponse<Data>) -> Void]()

    init(task: TwitterAPISessionTask) {
        self.task = task
    }

    public func streamResponse(queue: DispatchQueue, _ block: @escaping (TwitterAPIResponse<Data>) -> Void) -> Self {
        dataBlocks.append(block)
        return self
    }

    public func cancel() {
        task.cancel()
    }

    func append(chunk: Data) {
        for data in chunk.split(separator: chunkSeparator) {
            notify(result: .success(data))
        }
    }

    func complete(error: Error?) {
        if let error = error {
            notify(result: .failure(.responseFailed(reason: .invalidResponse(error: error))))
        }
    }

    private func notify(result: Result<Data, TwitterAPIKitError>) {

        let response = TwitterAPIResponse(
            request: currentRequest,
            response: httpResponse,
            data: result.success,
            result: result,
            rateLimit: nil
        )
        dataBlocks.forEach { $0(response) }
    }
}
