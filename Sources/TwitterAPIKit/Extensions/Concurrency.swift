import Foundation

#if compiler(>=5.5.2) && canImport(_Concurrency)

    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    extension TwitterAPISession {

        public func send(_ request: TwitterAPIRequest) async throws -> TwitterAPISuccessReponse {
            // Currently, cancel is not implemented because the following error occurs.
            // "Reference to captured var 'task' in concurrently-executing code"
            return try await withUnsafeThrowingContinuation { c in
                send(request) { c.resume(with: $0) }
            }
        }
    }

#endif
