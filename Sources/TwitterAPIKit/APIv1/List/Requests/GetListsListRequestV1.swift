import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-list
open class GetListsListRequestV1: TwitterAPIRequest {

    public let user: TwitterUserIdentifierV1
    public let reverse: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/lists/list.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        user.bind(param: &p)
        reverse.map { p["reverse"] = $0 }
        return p
    }

    public init(
        user: TwitterUserIdentifierV1,
        reverse: Bool? = .none
    ) {
        self.user = user
        self.reverse = reverse
    }
}
