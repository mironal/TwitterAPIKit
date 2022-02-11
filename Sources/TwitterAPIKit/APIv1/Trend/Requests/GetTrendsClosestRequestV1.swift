import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/trends/locations-with-trending-topics/api-reference/get-trends-closest
open class GetTrendsClosestRequestV1: TwitterAPIRequest {

    public let location: TwitterCoordinateV1

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/trends/closest.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        location.bind(param: &p)
        return p
    }

    public init(
        location: TwitterCoordinateV1
    ) {
        self.location = location
    }
}
