import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream-rules
open class GetTweetsSearchStreamRulesRequestV2: TwitterAPIRequest {

    public let ids: [String]?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/tweets/search/stream/rules"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        ids.map { p["ids"] = $0.joined(separator: ",") }
        return p
    }

    public init(
        ids: [String]? = .none
    ) {
        self.ids = ids
    }
}
