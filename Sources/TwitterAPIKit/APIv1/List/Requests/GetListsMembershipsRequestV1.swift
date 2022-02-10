import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-memberships
open class GetListsMembershipsRequestV1: TwitterAPIRequest {

    public let user: TwitterUserIdentifierV1
    public let count: Int?
    public let cursor: String?
    public let filterToOwnedLists: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/lists/memberships.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        user.bind(param: &p)
        count.map { p["count"] = $0 }
        cursor.map { p["cursor"] = $0 }
        filterToOwnedLists.map { p["filter_to_owned_lists"] = $0 }

        return p
    }

    public init(
        user: TwitterUserIdentifierV1,
        count: Int? = .none,
        cursor: String? = .none,
        filterToOwnedLists: Bool? = .none
    ) {
        self.user = user
        self.count = count
        self.cursor = cursor
        self.filterToOwnedLists = filterToOwnedLists
    }
}
