import Foundation

public protocol TwitterAPISessionTask {

    var taskIdentifier: Int { get }
    var currentRequest: URLRequest? { get }
    var originalRequest: URLRequest? { get }

    func cancel()
}

public struct NoOpSessionTask: TwitterAPISessionTask {

    public var taskIdentifier: Int {
        return 0
    }

    public var currentRequest: URLRequest? {
        return nil
    }

    public var originalRequest: URLRequest? {
        return nil
    }

    public func cancel() {}
}

extension URLSessionTask: TwitterAPISessionTask {

}
