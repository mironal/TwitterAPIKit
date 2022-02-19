import Foundation

public protocol TrendAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/trends/locations-with-trending-topics/api-reference/get-trends-available
    @discardableResult
    func getTrendsAvailable(
        _ request: GetTrendsAvailableRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/trends/locations-with-trending-topics/api-reference/get-trends-closest
    @discardableResult
    func getTrendsClosest(
        _ request: GetTrendsClosestRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/trends/trends-for-location/api-reference/get-trends-place
    @discardableResult
    func getTrends(
        _ request: GetTrendsPlaceRequestV1
    ) -> TwitterAPISessionTask

}

extension TwitterAPIKit.TwitterAPIImplV1: TrendAPIv1 {

    public func getTrendsAvailable(
        _ request: GetTrendsAvailableRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getTrendsClosest(
        _ request: GetTrendsClosestRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getTrends(
        _ request: GetTrendsPlaceRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }
}
