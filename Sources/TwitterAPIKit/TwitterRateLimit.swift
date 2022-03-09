import Foundation

/// https://developer.twitter.com/en/docs/rate-limits
/// https://developer.twitter.com/en/docs/twitter-api/v1/rate-limits
/// https://developer.twitter.com/en/docs/twitter-api/rate-limits
public struct TwitterRateLimit {
    public let limit: Int
    public let remaining: Int

    /// UTC epoch seconds
    public let reset: TimeInterval

    public init?(header: [AnyHashable: Any]) {

        guard let limit = parse(header, key: "x-rate-limit-limit"),
            let remaining = parse(header, key: "x-rate-limit-remaining"),
            let reset = parse(header, key: "x-rate-limit-reset")
        else {
            return nil
        }
        self.limit = limit
        self.remaining = remaining
        self.reset = TimeInterval(reset)
    }
}

extension TwitterRateLimit {
    public var resetDate: Date {
        return Date(timeIntervalSince1970: reset)
    }
}

private func parse(_ header: [AnyHashable: Any], key: String) -> Int? {
    // Normally, the header is a String.
    if let str = header[key] as? String, let value = Int(str) {
        return value
    }

    // just in case.
    if let int = header[key] as? Int {
        return int
    }
    return nil
}
