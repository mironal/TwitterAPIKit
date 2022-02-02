import Foundation

public protocol TweetAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-statuses-update
    @discardableResult
    func postUpdateStatus(
        _ request: PostUpdateStatusRequestV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask
}

extension TwitterAPIKit: TweetAPIv1 {

    public func postUpdateStatus(
        _ request: PostUpdateStatusRequestV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.send(request, completionHandler: completionHandler)
    }
}
