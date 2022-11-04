import Foundation

#if canImport(CommonCrypto)
    import CommonCrypto

    extension Data {
        fileprivate func hmac(key: Data) -> Data {

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

    func createHMACSHA1(key: Data, message: Data) -> Data {
        return message.hmac(key: key)
    }

#elseif canImport(Crypto)  // for Linux
    import Crypto
    func createHMACSHA1(key: Data, message: Data) -> Data {
        return Data(HMAC<Insecure.SHA1>.authenticationCode(for: message, using: SymmetricKey(data: key)))
    }
#else
    #error("Crypto is not available in this environment.")
#endif
