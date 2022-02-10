import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/geo/place-information/api-reference/get-geo-id-place_id
open class GetGeoPlaceIDRequestV1: TwitterAPIRequest {

    public let placeID: String

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/geo/id/\(placeID).json"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init(
        placeID: String
    ) {
        self.placeID = placeID
    }
}
