// swift-format-ignore-file

import Foundation

#if compiler(>=5.5.2) && canImport(_Concurrency)

// I'm not that familiar with Swift Concurrency, so please report any problems.

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension TwitterAPISessionDataTask {

    public var responseData: TwitterAPIResponse<Data> {
        get async {
            return await withTaskCancellationHandler(
                operation: {
                    return await withCheckedContinuation { c in
                        responseData { response in
                            c.resume(returning: response)
                        }
                    }
                },
                onCancel: {
                    cancel()
                })
        }
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension TwitterAPISessionJSONTask {

    public var responseObject: TwitterAPIResponse<Any> {
        get async {
            return await withTaskCancellationHandler(
                operation: {
                    return await withCheckedContinuation { c in
                        responseObject { response in
                            c.resume(returning: response)
                        }
                    }
                },
                onCancel: {
                    cancel()
                })
        }
    }

    public func responseDecodable<T: Decodable>(type: T.Type, decoder: JSONDecoder = TwitterAPIClient.defaultJSONDecoder) async -> TwitterAPIResponse<T> {
        return await withTaskCancellationHandler(
            operation: {
                return await withCheckedContinuation { c in
                    responseDecodable(type: type) { response in
                        c.resume(returning: response)
                    }
                }
            },
            onCancel: {
                cancel()
            })
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension TwitterAPISessionSpecializedTask {

    public var responseObject: TwitterAPIResponse<Success> {
        get async {
            return await withTaskCancellationHandler(
                operation: {
                    return await withCheckedContinuation { c in
                        responseObject { response in
                            c.resume(returning: response)
                        }
                    }
                }, onCancel: {
                    cancel()
                })
        }
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension TwitterAPISessionStreamTask {

    public func streamResponse(queue: DispatchQueue = .main) -> AsyncStream<TwitterAPIResponse<Data>> {
        return AsyncStream { continuation in
            streamResponse(queue: queue) { response in
                continuation.yield(response)
                if response.isError {
                    continuation.finish()
                }
            }
            continuation.onTermination = { @Sendable _ in
                cancel()
            }
        }
    }
}


@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension TwitterAPIClient {
    public func refreshOAuth20Token(type: TwitterAuthenticationMethod.OAuth20WithPKCEClientType, forceRefresh: Bool = false) async throws -> RefreshOAuth20TokenResultValue {
        return try await withCheckedThrowingContinuation { c in
            refreshOAuth20Token(type: type, forceRefresh: forceRefresh) { result in
                c.resume(with: result)
            }
        }
    }
}

#endif
