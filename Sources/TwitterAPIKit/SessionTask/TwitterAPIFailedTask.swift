import Foundation

public struct TwitterAPIFailedTask: TwitterAPISessionJSONTask, TwitterAPISessionStreamTask {

    public let error: TwitterAPIKitError

    public init(_ error: Error) {

        switch error {
        case let error as TwitterAPIKitError:
            self.error = error
        default:
            self.error = .unkonwn(error: error)
        }

    }
    public init(error: TwitterAPIKitError) {
        self.error = error
    }

    public var taskIdentifier: Int {
        return 0
    }

    public var currentRequest: URLRequest? {
        return nil
    }

    public var originalRequest: URLRequest? {
        return nil
    }

    public var httpResponse: HTTPURLResponse? {
        return nil
    }

    public func responseData(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> TwitterAPIFailedTask {
        queue.async {
            let response = TwitterAPIResponse<Data>(
                request: nil,
                response: nil,
                data: nil,
                result: .failure(error),
                rateLimit: nil)
            block(response)
        }
        return self
    }

    public func responseObject(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Any>) -> Void
    ) -> TwitterAPIFailedTask {
        queue.async {
            let response = TwitterAPIResponse<Any>(
                request: nil,
                response: nil,
                data: nil,
                result: .failure(error),
                rateLimit: nil)
            block(response)

        }
        return self
    }

    public func responseDecodable<T>(
        type: T.Type,
        decoder: JSONDecoder,
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<T>) -> Void
    ) -> TwitterAPIFailedTask where T: Decodable {
        queue.async {
            let response = TwitterAPIResponse<T>(
                request: nil,
                response: nil,
                data: nil,
                result: .failure(error),
                rateLimit: nil)
            block(response)

        }
        return self
    }

    public func streamResponse(queue: DispatchQueue, _ block: @escaping (TwitterAPIResponse<Data>) -> Void)
        -> TwitterAPIFailedTask
    {
        queue.async {
            let response = TwitterAPIResponse<Data>(
                request: nil,
                response: nil,
                data: nil,
                result: .failure(error),
                rateLimit: nil)
            block(response)
        }
        return self
    }

    public func cancel() {}
}
