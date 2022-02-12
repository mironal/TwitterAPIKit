import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-lookup
open class GetStatusesLookupRequestV1: TwitterAPIRequest {

    public let ids: [String]
    public let map: Bool?
    public let trimUser: Bool?
    public let includeCardUri: Bool?
    public let includeEntities: Bool?
    public let includeExtAltText: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/statuses/lookup.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["id"] = ids.joined(separator: ",")
        map.map { p["map"] = $0 }
        trimUser.map { p["trim_user"] = $0 }
        includeCardUri.map { p["include_card_uri"] = $0 }
        includeEntities.map { p["include_entities"] = $0 }
        includeExtAltText.map { p["include_ext_alt_text"] = $0 }
        return p
    }

    public init(
        ids: [String],
        map: Bool? = .none,
        trimUser: Bool? = .none,
        includeCardUri: Bool? = .none,
        includeEntities: Bool? = .none,
        includeExtAltText: Bool? = .none
    ) {
        self.ids = ids
        self.map = map
        self.trimUser = trimUser
        self.includeCardUri = includeCardUri
        self.includeEntities = includeEntities
        self.includeExtAltText = includeExtAltText
    }
}
