import Foundation

public protocol TrendAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/trends/locations-with-trending-topics/api-reference/get-trends-available
    func getTrendsAvailable(
        _ request: GetTrendsAvailableRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/trends/locations-with-trending-topics/api-reference/get-trends-closest
    func getTrendsClosest(
        _ request: GetTrendsClosestRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/trends/trends-for-location/api-reference/get-trends-place
    func getTrends(
        _ request: GetTrendsPlaceRequestV1
    ) -> TwitterAPISessionJSONTask

}

extension TwitterAPIKit.TwitterAPIImplV1: TrendAPIv1 {

    public func getTrendsAvailable(
        _ request: GetTrendsAvailableRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getTrendsClosest(
        _ request: GetTrendsClosestRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getTrends(
        _ request: GetTrendsPlaceRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
