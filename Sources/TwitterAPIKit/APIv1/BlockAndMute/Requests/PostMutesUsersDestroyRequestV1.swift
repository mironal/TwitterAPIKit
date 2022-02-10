import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-mutes-users-destroy
open class PostMutesUsersDestroyRequestV1: TwitterAPIRequest {

    public let user: TwitterUserIdentifierV1

    public var method: HTTPMethod {
        return .post
    }
    public var path: String {
        return "/1.1/mutes/users/destroy.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        user.bind(param: &p)
        return p
    }

    public init(
        user: TwitterUserIdentifierV1
    ) {
        self.user = user
    }
}
