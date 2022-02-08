import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/post-lists-members-create
open class PostListsMembersCreateRequestV1: TwitterAPIRequest {

    public let list: TwitterListIdentifierV1
    public let user: TwitterUserIdentifier

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/lists/members/create.json"
    }

    open var parameters: [String: Any]? {
        var p = [String: Any]()
        list.bind(param: &p)
        user.bind(param: &p)
        return p
    }
    public init(
        list: TwitterListIdentifierV1,
        user: TwitterUserIdentifier
    ) {
        self.list = list
        self.user = user
    }
}
