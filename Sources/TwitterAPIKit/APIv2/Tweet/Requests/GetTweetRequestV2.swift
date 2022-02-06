import Foundation

open class GetTweetRequestV2: TwitterAPIRequest {
    public let id: String

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/tweets/\(id)"
    }

    open var parameters: [String: Any]? {
        return [:]
    }

    public init(
        id: String
    ) {
        self.id = id
    }
}
