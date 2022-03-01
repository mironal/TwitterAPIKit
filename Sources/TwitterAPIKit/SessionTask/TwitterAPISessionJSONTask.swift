import Foundation

public protocol TwitterAPISessionJSONTask: TwitterAPISessionDataTask {

    @discardableResult
    func responseObject(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Any>) -> Void
    ) -> Self

    @discardableResult
    func responseDecodable<T: Decodable>(
        type: T.Type,
        decoder: JSONDecoder,
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self
}

// MARK: - Default argument functions

extension TwitterAPISessionJSONTask {

    @discardableResult
    public func responseObject(
        queue: DispatchQueue = .main,
        _ block: @escaping (TwitterAPIResponse<Any>) -> Void
    ) -> Self {
        return responseObject(queue: queue, block)
    }

    @discardableResult
    public func responseDecodable<T: Decodable>(
        type: T.Type,
        decoder: JSONDecoder,
        queue: DispatchQueue = .main,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self {
        return responseDecodable(type: type, decoder: decoder, queue: queue, block)
    }

    @discardableResult
    public func responseDecodable<T: Decodable>(
        type: T.Type,
        queue: DispatchQueue = .main,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self {
        return responseDecodable(type: type, decoder: TwitterAPIKit.defaultJSONDecoder, queue: queue, block)
    }
}
