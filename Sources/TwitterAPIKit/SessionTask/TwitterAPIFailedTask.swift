import Foundation

public struct TwitterAPIFailedTask: TwitterAPISessionJSONTask, TwitterAPISessionStreamTask {

    public let error: TwitterAPIKitError

    public init(_ error: TwitterAPIKitError) {
        self.error = error
    }

    public let taskIdentifier: Int = -1
    public let currentRequest: URLRequest? = nil
    public let originalRequest: URLRequest? = nil
    public let httpResponse: HTTPURLResponse? = nil

    public func responseData(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Data>) -> Void
    ) -> TwitterAPIFailedTask {
        queue.async {
            block(
                TwitterAPIResponse<Data>(
                    request: nil,
                    response: nil,
                    data: nil,
                    result: .failure(error),
                    rateLimit: nil)
            )
        }
        return self
    }

    public func responseObject(
        queue: DispatchQueue,
        _ block: @escaping (TwitterAPIResponse<Any>) -> Void
    ) -> TwitterAPIFailedTask {
        queue.async {
            block(
                TwitterAPIResponse<Any>(
                    request: nil,
                    response: nil,
                    data: nil,
                    result: .failure(error),
                    rateLimit: nil)
            )

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
            block(
                TwitterAPIResponse<T>(
                    request: nil,
                    response: nil,
                    data: nil,
                    result: .failure(error),
                    rateLimit: nil)
            )

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
