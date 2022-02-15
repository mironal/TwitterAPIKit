import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/developer-utilities/rate-limit-status/api-reference/get-application-rate_limit_status
open class GetApplicationRateLimitStatusRequestV1: TwitterAPIRequest {

    public let resources: [String]?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/application/rate_limit_status.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        resources.map { p["resources"] = $0.joined(separator: ",") }
        return p
    }

    public init(
        resources: [String]? = .none
    ) {
        self.resources = resources
    }
}
