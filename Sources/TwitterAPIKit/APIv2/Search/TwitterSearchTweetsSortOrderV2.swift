import Foundation

public enum TwitterSearchTweetsSortOrderV2: String {

    case recency
    case relevancy

    func bind(param: inout [String: Any]) {
        param["sort_order"] = rawValue
    }
}
