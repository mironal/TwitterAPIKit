import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/lists/pinned-lists/api-reference/delete-users-id-pinned-lists-list_id
open class DeleteUsersPinnedListsRequestV2: TwitterAPIRequest {

    public let id: String
    public let listID: String

    public var method: HTTPMethod {
        return .delete
    }

    public var path: String {
        return "/2/users/\(id)/pinned_lists/\(listID)"
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
