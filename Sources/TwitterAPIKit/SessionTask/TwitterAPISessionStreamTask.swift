import Foundation

public protocol TwitterAPISessionStreamTask: TwitterAPISessionTask {

    @discardableResult
    func streamResponse(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self

    @discardableResult
    func streamResponse(
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self
}
