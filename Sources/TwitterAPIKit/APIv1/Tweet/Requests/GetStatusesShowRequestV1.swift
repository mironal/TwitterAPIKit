import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-statuses-show-id
open class GetStatusesShowRequestV1: TwitterAPIRequest {

    public let id: String
    public let trimUser: Bool?
    public let includeCardUri: Bool?
    public let includeEntities: Bool?
    public let includeMyRetweet: Bool?
    public let includeExtAltText: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/statuses/show.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["id"] = id
        trimUser.map { p["trim_user"] = $0 }
        includeCardUri.map { p["include_card_uri"] = $0 }
        includeEntities.map { p["include_entities"] = $0 }
        includeMyRetweet.map { p["include_my_retweet"] = $0 }
        includeExtAltText.map { p["include_ext_alt_text"] = $0 }
        return p
    }

    public init(
        id: String,
        trimUser: Bool? = .none,
        includeCardUri: Bool? = .none,
        includeEntities: Bool? = .none,
        includeMyRetweet: Bool? = .none,
        includeExtAltText: Bool? = .none
    ) {
        self.id = id
        self.trimUser = trimUser
        self.includeCardUri = includeCardUri
        self.includeEntities = includeEntities
        self.includeMyRetweet = includeMyRetweet
        self.includeExtAltText = includeExtAltText
    }

}
