import Foundation

extension Data {

    func split(separator: Data, omittingEmptySubsequences: Bool = true) -> [Data] {
        var current = startIndex
        var chunks = [Data]()

        while let range = self[current...].range(of: separator) {

            if !omittingEmptySubsequences {
                chunks.append(self[current..<range.lowerBound])
            } else if range.lowerBound > current {
                chunks.append(self[current..<range.lowerBound])
            }

            current = range.upperBound
        }
        if current < self.endIndex {
            chunks.append(self[current...])
        }
        return chunks
    }

    func serialize() -> Result<Any, TwitterAPIKitError> {
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: self, options: [])
            return .success(jsonObj)
        } catch let error {
            return .failure(
                .responseSerializeFailed(
                    reason: .jsonSerializationFailed(error: error)
                )
            )
        }
    }

    func decode<T: Decodable>(
        _ type: T.Type,
        decoder: JSONDecoder
    ) -> Result<T, TwitterAPIKitError> {
        let result: Result<T, Error> = .init {
            return try decoder.decode(type, from: self)
        }
        return result.mapError { error in
            return .responseSerializeFailed(
                reason: .jsonDecodeFailed(error: error)
            )
        }
    }
}
