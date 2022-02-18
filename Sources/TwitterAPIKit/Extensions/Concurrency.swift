import Foundation

#if compiler(>=5.5.2) && canImport(_Concurrency)

    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    extension TwitterAPISessionResponse {

        // Currently, queue cannot be passed.

        public var responseData: Result<TwitterAPISuccessReponse, TwitterAPIKitError> {
            get async throws {
                return try await withTaskCancellationHandler(
                    operation: {
                        return try await withUnsafeThrowingContinuation { c in
                            responseData { result in
                                c.resume(returning: result)
                            }
                        }

                    },
                    onCancel: {
                        cancel()
                    })
            }
        }

        public var responseObject: Result<TwitterAPISerializedSuccessResponse, TwitterAPIKitError> {
            get async throws {
                return try await withTaskCancellationHandler(
                    operation: {
                        return try await withUnsafeThrowingContinuation { c in
                            responseObject { result in
                                c.resume(returning: result)
                            }
                        }
                    },
                    onCancel: {
                        cancel()
                    })
            }
        }

        public func responseDecodable<T: Decodable>(type: T.Type) async throws -> Result<
            TwitterAPIDecodedSuccessResponse<T>, TwitterAPIKitError
        > {
            return try await withTaskCancellationHandler(
                operation: {
                    return try await withUnsafeThrowingContinuation { c in
                        responseDecodable(type: type) { result in
                            c.resume(returning: result)
                        }
                    }
                },
                onCancel: {
                    cancel()
                })
        }
    }
#endif
