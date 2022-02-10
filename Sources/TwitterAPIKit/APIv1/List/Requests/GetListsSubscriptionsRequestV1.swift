import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-subscriptions
open class GetListsSubscriptionsRequestV1: TwitterAPIRequest {

    let user: TwitterUserIdentifierV1
    let count: Int?
    let cursor: String?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/lists/subscriptions.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        user.bind(param: &p)
        count.map { p["count"] = $0 }
        cursor.map { p["cursor"] = $0 }
        return p
    }

    public init(
        user: TwitterUserIdentifierV1,
        count: Int? = .none,
        cursor: String? = .none
    ) {
        self.user = user
        self.count = count
        self.cursor = cursor
    }
}
