import Foundation

public enum TwitterTimelineExcludeV2: String, TwitterAPIv2RequestParameter {
    case retweets
    case replies

    public var stringValue: String {
        return rawValue
    }
}

extension Set where Element == TwitterTimelineExcludeV2 {
    func bind(param: inout [String: Any]) {
        param["exclude"] = commaSeparatedString
    }
}
