import Foundation

public protocol TweetAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-statuses-update
    @discardableResult
    func postUpdateStatus(
        _ parameters: PostUpdateStatusParametersV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask
}

extension TwitterAPIKit: TweetAPIv1 {

    public func postUpdateStatus(
        _ parameters: PostUpdateStatusParametersV1,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.request(
            .post,
            path: "/1.1/statuses/update.json",
            with: parameters,
            completionHandler: completionHandler)
    }
}
