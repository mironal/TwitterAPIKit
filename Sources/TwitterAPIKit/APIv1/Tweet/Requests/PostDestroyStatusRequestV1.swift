import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-statuses-destroy-id
public struct PostDestroyStatusRequestV1: TwitterAPIRequest {

    public let id: String
    public let trimUser: Bool?

    var method: HTTPMethod {
        return .post
    }
    var path: String {
        return "/1.1/statuses/destroy/\(id).json"
    }

    var parameters: [String: Any]? {
        var p = [String: Any]()
        trimUser.map { p["trim_user"] = $0 }
        return p
    }

}
