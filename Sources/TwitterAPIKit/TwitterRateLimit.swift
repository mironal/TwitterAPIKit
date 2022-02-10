import Foundation

/// https://developer.twitter.com/ja/docs/basics/rate-limiting
public struct TwitterRateLimit {
    public let limit: Int
    public let remaining: Int

    /// UTC epoch seconds
    public let reset: TimeInterval

    public init(header: [AnyHashable: Any]) {
        limit = parse(header, key: "x-rate-limit-limit")
        remaining = parse(header, key: "x-rate-limit-remaining")
        reset = TimeInterval(parse(header, key: "x-rate-limit-reset"))
    }
}

extension TwitterRateLimit {
    public var resetDate: Date {
        return Date(timeIntervalSince1970: reset)
    }
}

private func parse(_ header: [AnyHashable: Any], key: String) -> Int {
    // Normally, the header is a String.
    if let str = header[key] as? String, let value = Int(str) {
        return value
    }

    // just in case.
    if let int = header[key] as? Int {
        return int
    }
    return 0
}
