import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/post-lists-id-members
open class PostListsMembersRequestV2: TwitterAPIRequest {

    public let id: String
    public let userID: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/lists/\(id)/members"
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["user_id"] = userID
        return p
    }

    public init(
        id: String,
        userID: String
    ) {
        self.id = id
        self.userID = userID
    }
}
