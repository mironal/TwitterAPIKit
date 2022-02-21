import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/post-lists
open class PostListsRequestV2: TwitterAPIRequest {

    public let name: String
    public let description: String?
    public let `private`: Bool?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/lists"
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["name"] = name
        description.map { p["description"] = $0 }
        `private`.map { p["private"] = $0 }
        return p
    }

    public init(
        name: String,
        description: String? = .none,
        private: Bool? = .none
    ) {
        self.name = name
        self.description = description
        self.private = `private`
    }
}
