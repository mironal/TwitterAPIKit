import Foundation

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

// MARK: - Default argument functions

extension TwitterAPISessionDataTask {
    @discardableResult
    public func responseData(
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self {
        return responseData(queue: .main, block)
    }
}

// MARK: - internal

extension TwitterAPISessionDataTask {
    func specialized<NewSuccess>(
        _ transform: @escaping (Data) throws -> NewSuccess
    )
        -> TwitterAPISessionSpecializedTask<NewSuccess>
    {
        return TwitterAPISessionSpecializedTask(task: self, transform: transform)
    }
}
