import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id
open class GetSpaceRequestV2: TwitterAPIRequest {

    public let id: String
    public let expansions: Set<TwitterSpaceExpansionsV2>?
    public let spaceFields: Set<TwitterSpaceFieldsV2>?
    public let topicFields: Set<TwitterTopicFieldsV2>?
    public let userFields: Set<TwitterUserFieldsV2>?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/spaces/\(id)"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        expansions?.bind(param: &p)
        spaceFields?.bind(param: &p)
        topicFields?.bind(param: &p)
        userFields?.bind(param: &p)
        return p
    }

    public init(
        id: String,
        expansions: Set<TwitterSpaceExpansionsV2>? = .none,
        spaceFields: Set<TwitterSpaceFieldsV2>? = .none,
        topicFields: Set<TwitterTopicFieldsV2>? = .none,
        userFields: Set<TwitterUserFieldsV2>? = .none
    ) {
        self.id = id
        self.expansions = expansions
        self.spaceFields = spaceFields
        self.topicFields = topicFields
        self.userFields = userFields
    }
}
