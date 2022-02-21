import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-by-creator-ids
open class GetSpacesByCreatorIDsRequestV2: TwitterAPIRequest {

    public let userIDs: [String]
    public let expansions: Set<TwitterSpaceExpansionsV2>?
    public let spaceFields: Set<TwitterSpaceFieldsV2>?
    public let topicFields: Set<TwitterTopicFieldsV2>?
    public let userFields: Set<TwitterUserFieldsV2>?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/spaces/by/creator_ids"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["user_ids"] = userIDs.joined(separator: ",")
        expansions?.bind(param: &p)
        spaceFields?.bind(param: &p)
        topicFields?.bind(param: &p)
        userFields?.bind(param: &p)
        return p
    }

    public init(
        userIDs: [String],
        expansions: Set<TwitterSpaceExpansionsV2>? = .none,
        spaceFields: Set<TwitterSpaceFieldsV2>? = .none,
        topicFields: Set<TwitterTopicFieldsV2>? = .none,
        userFields: Set<TwitterUserFieldsV2>? = .none
    ) {
        self.userIDs = userIDs
        self.expansions = expansions
        self.spaceFields = spaceFields
        self.topicFields = topicFields
        self.userFields = userFields
    }
}
