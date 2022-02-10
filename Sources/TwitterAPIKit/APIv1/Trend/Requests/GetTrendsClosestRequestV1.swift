import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/trends/locations-with-trending-topics/api-reference/get-trends-closest
open class GetTrendsClosestRequestV1: TwitterAPIRequest {

    public struct Coordinate {
        var lat: Double
        var long: Double
    }

    public let location: Coordinate

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/trends/closest.json"
    }

    open var parameters: [String: Any] {
        return [
            "lat": location.lat,
            "long": location.long,
        ]
    }

    public init(
        location: Coordinate
    ) {
        self.location = location
    }
}
