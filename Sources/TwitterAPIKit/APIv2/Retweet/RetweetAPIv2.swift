import Foundation

public protocol RetweetAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/get-tweets-id-retweeted_by
    @discardableResult
    func getRetweetedBy(
        _ request: GetTweetsRetweetedByRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask

}

extension TwitterAPIKit: RetweetAPIv2 {

    public func getRetweetedBy(
        _ request: GetTweetsRetweetedByRequestV2,
        completionHandler: @escaping (Result<TwitterAPISuccessReponse, TwitterAPIKitError>) -> Void
    ) -> TwitterAPISessionTask {
        return session.send(request, completionHandler: completionHandler)
    }
}
