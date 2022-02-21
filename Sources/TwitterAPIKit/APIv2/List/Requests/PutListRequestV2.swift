import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/put-lists-id
open class PutListRequestV2: TwitterAPIRequest {

    public let id: String
    public let description: String?
    public let name: String?
    public let `private`: Bool?

    public var method: HTTPMethod {
        return .put
    }

    public var path: String {
        return "/2/lists/\(id)"
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        description.map { p["description"] = $0 }
        name.map { p["name"] = $0 }
        `private`.map { p["private"] = $0 }
        return p
    }

    public init(
        id: String,
        description: String? = .none,
        name: String? = .none,
        private: Bool? = .none
    ) {
        self.id = id
        self.description = description
        self.name = name
        self.private = `private`
    }
}
