import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-members-show
open class GetListsMembersShowRequestV1: TwitterAPIRequest {

    public let list: TwitterListIdentifierV1
    public let user: TwitterUserIdentifierV1
    public let includeEntities: Bool?
    public let skipStatus: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/lists/members/show.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        list.bind(param: &p)
        user.bind(param: &p)
        includeEntities.map { p["include_entities"] = $0 }
        skipStatus.map { p["skip_status"] = $0 }
        return p
    }

    public init(
        list: TwitterListIdentifierV1,
        user: TwitterUserIdentifierV1,
        includeEntities: Bool? = .none,
        skipStatus: Bool? = .none
    ) {
        self.list = list
        self.user = user
        self.includeEntities = includeEntities
        self.skipStatus = skipStatus
    }
}
