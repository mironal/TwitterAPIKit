import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-statuses-destroy-id
public struct PostDestroyStatusParameterV1: TwitterAPIParameters {

    public let id: String
    public let trimUser: Bool

    var parameters: [String: Any]? = nil

}
