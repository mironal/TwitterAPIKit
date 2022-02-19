import Foundation

public protocol GeoAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/geo/places-near-location/api-reference/get-geo-reverse_geocode
    @discardableResult
    func getReverseGeocode(
        _ request: GetGeoReverseGeocodeRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/geo/place-information/api-reference/get-geo-id-place_id
    @discardableResult
    func getGeoPlace(
        _ request: GetGeoPlaceIDRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/geo/places-near-location/api-reference/get-geo-search
    @discardableResult
    func searchGeo(
        _ request: GetGeoSearchRequestV1
    ) -> TwitterAPISessionJSONTask

}

extension TwitterAPIKit.TwitterAPIImplV1: GeoAPIv1 {

    public func getReverseGeocode(
        _ request: GetGeoReverseGeocodeRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getGeoPlace(
        _ request: GetGeoPlaceIDRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func searchGeo(
        _ request: GetGeoSearchRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
