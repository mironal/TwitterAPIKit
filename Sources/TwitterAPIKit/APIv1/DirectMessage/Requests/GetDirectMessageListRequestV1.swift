import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/sending-and-receiving/api-reference/list-events
open class GetDirectMessageListRequestV1: TwitterAPIRequest {

    /// Max: 50
    public let count: Int?
    public let cursor: String?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/direct_messages/events/list.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()

        count.map { p["count"] = $0 }
        cursor.map { p["cursor"] = $0 }

        return p
    }

    public init(count: Int? = .none, cursor: String? = .none) {
        self.count = count
        self.cursor = cursor
    }
}
