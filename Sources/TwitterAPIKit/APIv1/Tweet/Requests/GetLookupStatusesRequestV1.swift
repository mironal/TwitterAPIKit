import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-lookup
open class GetLookupStatusesRequestV1: TwitterAPIRequest {

    public let id: [String]
    public let includeEntities: Bool?
    public let trimUser: Bool?
    public let map: Bool?
    public let includeExtAltText: Bool?
    public let includeCardUri: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/statuses/lookup.json"
    }

    open var parameters: [String: Any]? {
        var p = [String: Any]()

        p["id"] = id.joined(separator: ",")
        includeEntities.map { p["include_entities"] = $0 }
        trimUser.map { p["trim_user"] = $0 }
        map.map { p["map"] = $0 }
        includeExtAltText.map { p["include_ext_alt_text"] = $0 }
        includeCardUri.map { p["include_card_uri"] = $0 }

        return p
    }

    public init(
        id: [String],
        includeEntities: Bool? = .none,
        trimUser: Bool? = .none,
        map: Bool? = .none,
        includeExtAltText: Bool? = .none,
        includeCardUri: Bool? = .none
    ) {
        self.id = id
        self.includeEntities = includeEntities
        self.trimUser = trimUser
        self.map = map
        self.includeExtAltText = includeEntities
        self.includeCardUri = includeCardUri
    }

}
