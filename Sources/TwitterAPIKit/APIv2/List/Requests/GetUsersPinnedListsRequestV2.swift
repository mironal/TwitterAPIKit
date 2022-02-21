import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/lists/pinned-lists/api-reference/get-users-id-pinned_lists
open class GetUsersPinnedListsRequestV2: TwitterAPIRequest {

    public let id: String
    public let expansions: Set<TwitterListExpansionsV2>?
    public let listFields: Set<TwitterListFieldsV2>?
    public let userFields: Set<TwitterUserFieldsV2>?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/users/\(id)/pinned_lists"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        expansions?.bind(param: &p)
        listFields?.bind(param: &p)
        userFields?.bind(param: &p)
        return p
    }

    public init(
        id: String,
        expansions: Set<TwitterListExpansionsV2>? = .none,
        listFields: Set<TwitterListFieldsV2>? = .none,
        userFields: Set<TwitterUserFieldsV2>? = .none
    ) {
        self.id = id
        self.expansions = expansions
        self.listFields = listFields
        self.userFields = userFields
    }
}
