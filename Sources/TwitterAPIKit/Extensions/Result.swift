import Foundation

extension Result where Success == TwitterAPISuccessReponse, Failure == TwitterAPIKitError {

    public func serialize() -> Result<TwitterAPISerializedSuccessResponse, Failure> {
        return flatMap { success in
            do {
                let data = success.data
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                return .success((jsonObj, success.rateLimit, success.response))
            } catch let error {
                return .failure(
                    .responseSerializeFailed(
                        reason: .jsonSerializationFailed(
                            error: error,
                            data: success.data,
                            rateLimit: success.rateLimit
                        ))
                )
            }
        }
    }

    public func decode<T>(_ type: T.Type, decodar: JSONDecoder = TwitterAPIKit.defaultJSONDecoder) -> Result<
        TwitterAPIDecodedSuccessResponse<T>, Failure
    > {
        return flatMap { success in

            let result: Result<T, Error> = .init {
                return try decodar.decode(type, from: success.data)
            }
            return result.map { data in
                return (data: data, rateLimit: success.rateLimit, response: success.response)
            }
            .mapError { error in
                return .responseSerializeFailed(
                    reason: .jsonDecodeFailed(
                        error: error,
                        data: success.data,
                        rateLimit: success.rateLimit
                    ))
            }
        }
    }
}
