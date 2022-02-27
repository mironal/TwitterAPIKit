import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules#Validate
open class PostTweetsSearchStreamRulesRequestV2: TwitterAPIRequest {

    public struct Add {
        public let value: String
        public let tag: String?
        public init(value: String, tag: String? = .none) {
            self.value = value
            self.tag = tag
        }
    }

    public let dryRun: Bool?
    public let add: [Add]
    public let deleteIDs: [String]?

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
        if !add.isEmpty {
            p["add"] = add.map {
                return [
                    "value": $0.value,
                    "tag": $0.tag,
                ].compactMapValues { $0 }
            }
        }

        deleteIDs.map {
            p["delete"] = [
                "ids": $0
            ]
        }
        return p
    }

    public init(
        dryRun: Bool? = .none,
        add: [Add] = [],
        deleteIDs: [String]? = .none
    ) {
        self.dryRun = dryRun
        self.add = add
        self.deleteIDs = deleteIDs
    }
}
