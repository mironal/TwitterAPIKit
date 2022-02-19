import Foundation

extension Result where Success == Data, Failure == TwitterAPIKitError {

    func serialize() -> Result<Any, Failure> {
        return flatMap { data in
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                return .success(jsonObj)
            } catch let error {
                return .failure(
                    .responseSerializeFailed(
                        reason: .jsonSerializationFailed(
                            error: error
                        ))
                )
            }
        }
    }

    func decode<T: Decodable>(
        _ type: T.Type,
        decodar: JSONDecoder = TwitterAPIKit.defaultJSONDecoder
    ) -> Result<T, Failure> {
        return flatMap { data in
            let result: Result<T, Error> = .init {
                return try decodar.decode(type, from: data)
            }
            return result.mapError { error in
                return .responseSerializeFailed(
                    reason: .jsonDecodeFailed(error: error)
                )
            }
        }
    }
}

extension Result where Failure == TwitterAPIKitError {
    var success: Success? {
        guard case .success(let value) = self else { return nil }
        return value
    }
    var error: Failure? {
        guard case .failure(let error) = self else { return nil }
        return error
    }
}
