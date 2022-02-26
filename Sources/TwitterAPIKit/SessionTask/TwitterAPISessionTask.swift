import Foundation

public protocol TwitterAPISessionTask {
    var taskIdentifier: Int { get }
    var currentRequest: URLRequest? { get }
    var originalRequest: URLRequest? { get }

    func cancel()
}

/*

 TwitterAPISessionTask
    |- TwitterAPISessionDataTask
    |   |- TwitterAPISessionJSONTask
    |   |- TwitterAPISessionSpecializedTask
    |- TwitterAPISessionStreamTask
 */
