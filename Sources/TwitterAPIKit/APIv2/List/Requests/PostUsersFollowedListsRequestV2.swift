import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/post-users-id-followed-lists
open class PostUsersFollowedListsRequestV2: TwitterAPIRequest {

    public let id: String
    public let listID: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/users/\(id)/followed_lists"
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["list_id"] = listID
        return p
    }

    public init(
        id: String,
        listID: String
    ) {
        self.id = id
        self.listID = listID
    }
}
