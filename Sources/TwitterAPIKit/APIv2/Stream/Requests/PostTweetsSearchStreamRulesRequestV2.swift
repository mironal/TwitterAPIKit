import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules#Validate
open class PostTweetsSearchStreamRulesRequestV2: TwitterAPIRequest {

    public struct Rule {
        public let value: String
        public let tag: String?
        public init(value: String, tag: String? = .none) {
            self.value = value
            self.tag = tag
        }
    }

    public enum Operation {
        case add([Rule])
        case delete([String] /* rule IDs */)
    }

    public let dryRun: Bool?
    public let operation: PostTweetsSearchStreamRulesRequestV2.Operation

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/tweets/search/stream/rules"
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    open var queryParameters: [String: Any] {
        var p = [String: Any]()
        dryRun.map { p["dry_run"] = $0 }
        return p
    }

    open var bodyParameters: [String: Any] {
        var p = [String: Any]()

        switch operation {
        case .add(let rules):
            p["add"] = rules.map {
                return [
                    "value": $0.value,
                    "tag": $0.tag,
                ].compactMapValues { $0 }
            }
        case .delete(let ids):
            p["delete"] = ["ids": ids]
        }

        return p
    }

    public init(
        operation: Operation,
        dryRun: Bool? = .none
    ) {
        self.operation = operation
        self.dryRun = dryRun
    }
}
