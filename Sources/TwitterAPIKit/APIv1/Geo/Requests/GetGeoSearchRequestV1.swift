import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/geo/places-near-location/api-reference/get-geo-search
open class GetGeoSearchRequestV1: TwitterAPIRequest {

    public enum Location {
        case coordinate(TwitterCoordinateV1)
        case query(String)
        case ip(String)
        func bind(param: inout [String: Any]) {
            switch self {
            case .coordinate(let twitterCoordinate):
                twitterCoordinate.bind(param: &param)
            case .query(let string):
                param["query"] = string
            case .ip(let string):
                param["ip"] = string
            }
        }
    }

    public let location: Location
    public let maxResults: Int?
    public let granularity: TwitterGranularityV1?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/geo/search.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        location.bind(param: &p)
        maxResults.map { p["max_results"] = $0 }
        granularity?.bind(param: &p)
        return p
    }

    public init(
        location: Location,
        maxResults: Int? = .none,
        granularity: TwitterGranularityV1? = .none
    ) {
        self.location = location
        self.maxResults = maxResults
        self.granularity = granularity
    }

}
