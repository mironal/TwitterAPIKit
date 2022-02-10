import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/trends/locations-with-trending-topics/api-reference/get-trends-available
open class GetTrendsAvailableRequestV1: TwitterAPIRequest {

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/trends/available.json"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init() {}

}
