import Foundation

public protocol TwitterAPISessionTask {
    var taskIdentifier: Int { get }
    var currentRequest: URLRequest? { get }
    var originalRequest: URLRequest? { get }
    var httpResponse: HTTPURLResponse? { get }

    func cancel()
}

extension URLSessionTask: TwitterAPISessionTask {
    public var httpResponse: HTTPURLResponse? {
        return response as? HTTPURLResponse
    }
}
