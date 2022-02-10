import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-favorites-create
open class PostFavoriteRequestV1: TwitterAPIRequest {

    public let id: String
    public let includeEntities: Bool?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/favorites/create.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["id"] = id
        includeEntities.map { p["include_entities"] = $0 }
        return p
    }

    public init(
        id: String,
        includeEntities: Bool? = .none
    ) {
        self.id = id
        self.includeEntities = includeEntities
    }

}
