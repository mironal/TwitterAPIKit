import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-members-destroy_all
open class PostListsMembersDestroyAllRequestV1: TwitterAPIRequest {

    public let list: TwitterListIdentifierV1
    public let users: TwitterUsersIdentifierV1

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/lists/members/destroy_all.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        list.bind(param: &p)
        users.bind(param: &p)
        return p
    }

    public init(
        list: TwitterListIdentifierV1,
        users: TwitterUsersIdentifierV1
    ) {
        self.list = list
        self.users = users
    }
}
