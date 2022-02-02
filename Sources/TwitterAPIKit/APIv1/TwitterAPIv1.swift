import Foundation

public protocol TwitterAPIv1 {

    func getHomeTimeline(
        _ parameter: GetHomeTimelineParameter,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask
}
