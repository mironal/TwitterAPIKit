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
