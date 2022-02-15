import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-destroy
open class PostCollectionsDestroyRequestV1: TwitterAPIRequest {

    public let id: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/collections/destroy.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["id"] = id
        return p
    }

    public init(
        id: String
    ) {
        self.id = id
    }
}
