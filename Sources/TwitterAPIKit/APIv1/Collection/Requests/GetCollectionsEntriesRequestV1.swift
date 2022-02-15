import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/get-collections-entries
open class GetCollectionsEntriesRequestV1: TwitterAPIRequest {

    public let id: String
    public let count: Int?
    public let maxPosition: String?
    public let minPosition: String?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/collections/entries.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["id"] = id
        count.map { p["count"] = $0 }
        maxPosition.map { p["max_position"] = $0 }
        minPosition.map { p["min_position"] = $0 }
        return p
    }

    public init(
        id: String,
        count: Int? = .none,
        maxPosition: String? = .none,
        minPosition: String? = .none
    ) {
        self.id = id
        self.count = count
        self.maxPosition = maxPosition
        self.minPosition = minPosition
    }
}
