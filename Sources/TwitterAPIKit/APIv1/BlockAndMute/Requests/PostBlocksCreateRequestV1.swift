import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-blocks-create
open class PostBlocksCreateRequestV1: TwitterAPIRequest {

    public let user: TwitterUserIdentifierV1
    public let includeEntities: Bool?
    public let skipStatus: Bool?

    public var method: HTTPMethod {
        return .post
    }
    public var path: String {
        return "/1.1/blocks/create.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        user.bind(param: &p)
        includeEntities.map { p["include_entities"] = $0 }
        skipStatus.map { p["skip_status"] = $0 }
        return p
    }

    public init(
        user: TwitterUserIdentifierV1,
        includeEntities: Bool? = .none,
        skipStatus: Bool? = .none
    ) {
        self.user = user
        self.includeEntities = includeEntities
        self.skipStatus = skipStatus
    }
}
