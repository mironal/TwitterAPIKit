import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friendships-no_retweets-ids
open class GetFriendshipsNoRetweetsIDsRequestV1: TwitterAPIRequest {

    public let stringifyIDs: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/friendships/no_retweets/ids.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        stringifyIDs.map { p["stringify_ids"] = $0 }
        return p
    }

    public init(
        stringifyIDs: Bool? = .none
    ) {
        self.stringifyIDs = stringifyIDs
    }
}
