import Foundation

open class TrendAPIv1: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/trends/locations-with-trending-topics/api-reference/get-trends-available
    public func getTrendsAvailable(
        _ request: GetTrendsAvailableRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/trends/locations-with-trending-topics/api-reference/get-trends-closest
    public func getTrendsClosest(
        _ request: GetTrendsClosestRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/trends/trends-for-location/api-reference/get-trends-place
    public func getTrends(
        _ request: GetTrendsPlaceRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
