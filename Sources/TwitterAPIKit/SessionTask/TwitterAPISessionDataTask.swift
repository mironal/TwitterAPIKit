import Foundation

public protocol TwitterAPISessionDataTask: TwitterAPISessionTask {

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
        queue: DispatchQueue = .main,
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self {
        return responseData(queue: queue, block)
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
