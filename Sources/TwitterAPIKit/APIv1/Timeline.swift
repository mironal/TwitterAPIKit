import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-home_timeline
public struct GetHomeTimelineParameter: TwitterAPIParameter {

    public let count: Int

    let method: HTTPMethod = .get
    let path: String = "/1.1/statuses/home_timeline.json"
    var parameters: [String: Any]? {
        return [
            "count": count
        ]
    }

    public init(
        count: Int
    ) {
        self.count = count
    }
}

extension TwitterAPIKit: TwitterAPIv1 {
    public func getHomeTimeline(
        _ parameter: GetHomeTimelineParameter,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.request(parameter, completionHandler: completionHandler)
    }
}
