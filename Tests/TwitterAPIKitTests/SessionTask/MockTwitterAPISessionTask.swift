import Foundation
import TwitterAPIKit

class MockTwitterAPISessionTask: TwitterAPISessionTask {

    var taskIdentifier: Int
    var currentRequest: URLRequest?
    var originalRequest: URLRequest?
    var httpResponse: HTTPURLResponse?
    var cancelled = false

    init(
        taskIdentifier: Int,
        currentRequest: URLRequest? = nil,
        originalRequest: URLRequest? = nil,
        httpResponse: HTTPURLResponse? = nil
    ) {
        self.taskIdentifier = taskIdentifier
        self.currentRequest = currentRequest
        self.originalRequest = originalRequest
        self.httpResponse = httpResponse
    }

    func cancel() {
        cancelled = true
    }
}

class MockTwitterAPISessionDataTask: MockTwitterAPISessionTask, TwitterAPISessionDataTask {

    var data: Data

    init(
        data: Data,
        taskIdentifier: Int,
        currentRequest: URLRequest? = nil,
        originalRequest: URLRequest? = nil,
        httpResponse: HTTPURLResponse? = nil
    ) {
        self.data = data
        super.init(
            taskIdentifier: taskIdentifier, currentRequest: currentRequest, originalRequest: originalRequest,
            httpResponse: httpResponse)
    }

    func responseData(queue: DispatchQueue, _ block: @escaping (TwitterAPIResponse<Data>) -> Void) -> Self {

        queue.async { [weak self] in
            guard let self = self else { return }
            block(
                .init(
                    request: self.currentRequest,
                    response: self.httpResponse,
                    data: self.data,
                    result: .success(self.data),
                    rateLimit: TwitterRateLimit(header: [:])
                ))
        }
        return self
    }

    func responseData(_ block: @escaping (TwitterAPIResponse<Data>) -> Void) -> Self {
        return responseData(queue: .main, block)
    }
}
