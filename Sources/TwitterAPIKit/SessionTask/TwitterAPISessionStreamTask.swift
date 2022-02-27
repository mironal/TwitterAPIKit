import Foundation

public protocol TwitterAPISessionStreamTask: TwitterAPISessionTask {

    @discardableResult
    func streamResponse(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self
}

// MARK: - Default argument functions

extension TwitterAPISessionStreamTask {
    @discardableResult
    func streamResponse(
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self {
        return streamResponse(queue: .main, block)
    }
}
