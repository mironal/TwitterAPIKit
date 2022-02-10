import Foundation

public protocol GeoAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/geo/places-near-location/api-reference/get-geo-reverse_geocode
    @discardableResult
    func getReverseGeocode(
        _ request: GetGeoReverseGeocodeRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/geo/place-information/api-reference/get-geo-id-place_id
    @discardableResult
    func getGeoPlace(
        _ request: GetGeoPlaceIDRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask

}

extension TwitterAPIKit: GeoAPIv1 {

    public func getReverseGeocode(
        _ request: GetGeoReverseGeocodeRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }

    public func getGeoPlace(
        _ request: GetGeoPlaceIDRequestV1,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }
}
