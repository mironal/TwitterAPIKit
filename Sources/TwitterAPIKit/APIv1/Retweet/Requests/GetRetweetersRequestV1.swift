import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-retweeters-ids
open class GetRetweetersRequestV1: TwitterAPIRequest {

    // Status ID
    let id: String
    let count: Int?
    let cursor: String?
    let stringifyIDs: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {

        return "/1.1/statuses/retweeters/ids.json"
    }

    open var parameters: [String: Any] {

        var p = [String: Any]()

        p["id"] = id
        count.map { p["count"] = $0 }
        cursor.map { p["cursor"] = $0 }
        stringifyIDs.map { p["stringify_ids"] = $0 }

        return p
    }

    public init(
        id: String,
        count: Int? = .none,
        cursor: String? = .none,
        stringifyIDs: Bool? = .none
    ) {
        self.id = id
        self.count = count
        self.cursor = cursor
        self.stringifyIDs = stringifyIDs
    }
}
