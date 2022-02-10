import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-show
open class GetListsShowRequestV1: TwitterAPIRequest {

    public let list: TwitterListIdentifierV1

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/lists/show.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        list.bind(param: &p)
        return p
    }

    public init(
        list: TwitterListIdentifierV1
    ) {
        self.list = list
    }
}
