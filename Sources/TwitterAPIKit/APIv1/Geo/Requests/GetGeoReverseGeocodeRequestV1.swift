import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/geo/places-near-location/api-reference/get-geo-reverse_geocode
open class GetGeoReverseGeocodeRequestV1: TwitterAPIRequest {
    public struct Coordinate {
        var lat: Double
        var long: Double
    }

    public enum Accuracy {
        /// meter
        case m(Int)
        /// feet
        case ft(Int)
    }

    public enum Granularity: String {
        case neighborhood
        case city
        case admin
        case country
    }
    public let location: Coordinate
    public let accuracy: Accuracy?
    public let maxResults: Int?
    public let granularity: Granularity?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/geo/reverse_geocode.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["location"] = location
        accuracy.map { p["accuracy"] = $0 }
        maxResults.map { p["max_results"] = $0 }
        granularity.map { p["granularity"] = $0.rawValue }
        return p
    }

    public init(
        location: Coordinate,
        accuracy: Accuracy? = .none,
        maxResults: Int? = .none,
        granularity: Granularity? = .none
    ) {
        self.location = location
        self.accuracy = accuracy
        self.maxResults = maxResults
        self.granularity = granularity
    }
}
