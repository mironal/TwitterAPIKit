import CommonCrypto
import Foundation

extension Data {
    func hmac(key: Data) -> Data {

        // Thanks: https://github.com/jernejstrasner/SwiftCrypto

        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        return withUnsafeBytes { bytes -> Data in
            let result = UnsafeMutablePointer<UInt8>.allocate(capacity: digestLen)
            defer {
                result.deallocate()
            }

            key.withUnsafeBytes { body in
                CCHmac(
                    CCHmacAlgorithm(kCCHmacAlgSHA1),
                    body.baseAddress,
                    key.count, bytes.baseAddress,
                    count,
                    result
                )
            }

            return Data(bytes: result, count: digestLen)
        }
    }
}
