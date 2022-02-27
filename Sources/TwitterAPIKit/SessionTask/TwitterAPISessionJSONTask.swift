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
    public func responseData(
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> Self {
        return responseData(queue: .main, block)
    }

    @discardableResult
    public func responseObject(
        _ block: @escaping (TwitterAPIResponse<Any>) -> Void
    ) -> Self {
        return responseObject(queue: .main, block)
    }

    @discardableResult
    public func responseDecodable<T: Decodable>(
        type: T.Type,
        decoder: JSONDecoder,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self {
        return responseDecodable(type: type, decoder: decoder, queue: .main, block)
    }

    @discardableResult
    public func responseDecodable<T: Decodable>(
        type: T.Type,
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self {
        return responseDecodable(type: type, decoder: TwitterAPIKit.defaultJSONDecoder, queue: queue, block)
    }

    @discardableResult
    public func responseDecodable<T: Decodable>(
        type: T.Type,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> Self {
        return responseDecodable(type: type, decoder: TwitterAPIKit.defaultJSONDecoder, queue: .main, block)
    }
}
