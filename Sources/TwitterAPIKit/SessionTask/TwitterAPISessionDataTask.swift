import Foundation

public protocol TwitterAPISessionDataTask: TwitterAPISessionTask {

    @discardableResult
    func responseData(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self

    @discardableResult
    func responseData(
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self
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
