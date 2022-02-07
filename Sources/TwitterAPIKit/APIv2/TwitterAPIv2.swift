import Foundation

// https://developer.twitter.com/en/docs/api-reference-index

public typealias TwitterAPIv2 =
    TweetAPIv2

public protocol TwitterAPIV2RequestParameter {
    var stringValue: String { get }
}

extension Set where Element: TwitterAPIV2RequestParameter {
    var commaSeparatedString: String {
        return map { $0.stringValue }.joined(separator: ",")
    }
}
