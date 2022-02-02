import Foundation

public class PostUpdateStatusRequestV1: TwitterAPIRequest {

    // TODO: Other parameters

    public let status: String

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        return "/1.1/statuses/update.json"
    }

    var parameters: [String: Any]? {
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
