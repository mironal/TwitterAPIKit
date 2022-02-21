import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/delete-lists-id-members-user_id
open class DeleteListsMembersRequestV2: TwitterAPIRequest {

    public let id: String
    public let userID: String

    public var method: HTTPMethod {
        return .delete
    }

    public var path: String {
        return "/2/lists/\(id)/members/\(userID)"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init(
        id: String,
        userID: String
    ) {
        self.id = id
        self.userID = userID
    }
}
