import Foundation

open class PostUpdateStatusRequestV1: TwitterAPIRequest {

    // TODO: Other parameters

    public let status: String

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/statuses/update.json"
    }

    open var parameters: [String: Any]? {
        var p = [String: Any]()
        p["status"] = status
        return p
    }

    public init(
        status: String
    ) {
        self.status = status
    }
}
