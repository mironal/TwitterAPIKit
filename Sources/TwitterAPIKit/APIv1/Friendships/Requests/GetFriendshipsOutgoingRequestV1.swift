import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-outgoing
open class GetFriendshipsOutgoingRequestV1: TwitterAPIRequest {

    public let cursor: String?
    public let stringifyIDs: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/friendships/outgoing"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        cursor.map { p["cursor"] = $0 }
        stringifyIDs.map { p["stringify_ids"] = $0 }
        return p
    }

    public init(
        cursor: String? = .none,
        stringifyIDs: Bool? = .none
    ) {
        self.cursor = cursor
        self.stringifyIDs = stringifyIDs
    }
}
