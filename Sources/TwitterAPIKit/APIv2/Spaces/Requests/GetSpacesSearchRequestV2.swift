import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/spaces/search/api-reference/get-spaces-search
open class GetSpacesSearchRequestV2: TwitterAPIRequest {

    public enum State: String {
        case all
        case live
        case scheduled
        func bind(param: inout [String: Any]) {
            param["state"] = rawValue
        }
    }

    public let query: String
    public let expansions: Set<TwitterSpaceExpansionsV2>?
    public let spaceFields: Set<TwitterSpaceFieldsV2>?
    public let state: State?
    public let topicFields: Set<TwitterTopicFieldsV2>?
    public let userFields: Set<TwitterUserFieldsV2>?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/spaces/search"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["query"] = query
        expansions?.bind(param: &p)
        spaceFields?.bind(param: &p)
        state?.bind(param: &p)
        topicFields?.bind(param: &p)
        userFields?.bind(param: &p)
        return p
    }

    public init(
        query: String,
        expansions: Set<TwitterSpaceExpansionsV2>? = .none,
        spaceFields: Set<TwitterSpaceFieldsV2>? = .none,
        state: State? = .none,
        topicFields: Set<TwitterTopicFieldsV2>? = .none,
        userFields: Set<TwitterUserFieldsV2>? = .none
    ) {
        self.query = query
        self.expansions = expansions
        self.spaceFields = spaceFields
        self.state = state
        self.topicFields = topicFields
        self.userFields = userFields
    }
}
