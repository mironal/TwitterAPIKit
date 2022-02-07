import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-members-create_all
open class PostListsMembersCreateAllRequestV1: TwitterAPIRequest {

    public let list: TwitterListIdentifierV1
    public let users: TwitterUsersIdentifier

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/lists/members/create_all.json"
    }

    open var parameters: [String: Any]? {
        var p = [String: Any]()
        list.bind(param: &p)
        users.bind(param: &p)
        return p
    }

    public init(
        list: TwitterListIdentifierV1,
        users: TwitterUsersIdentifier
    ) {
        self.list = list
        self.users = users
    }
}
