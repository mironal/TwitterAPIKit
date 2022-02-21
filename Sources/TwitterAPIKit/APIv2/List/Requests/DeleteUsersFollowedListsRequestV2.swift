import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/delete-users-id-followed-lists-list_id
open class DeleteUsersFollowedListsRequestV2: TwitterAPIRequest {

    public let id: String
    public let listID: String

    public var method: HTTPMethod {
        return .delete
    }

    public var path: String {
        return "/2/users/\(id)/followed_lists/\(listID)"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init(
        id: String,
        listID: String
    ) {
        self.id = id
        self.listID = listID
    }
}
