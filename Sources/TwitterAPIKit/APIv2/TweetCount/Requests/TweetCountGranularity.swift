import Foundation

public enum TweetCountGranularityV2: String {

    case minute
    case hour
    case day

    func bind(param: inout [String: Any]) {
        param["granularity"] = rawValue
    }
}
