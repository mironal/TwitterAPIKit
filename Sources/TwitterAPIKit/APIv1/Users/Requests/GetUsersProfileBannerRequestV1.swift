import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-users-profile_banner
open class GetUsersProfileBannerRequestV1: TwitterAPIRequest {

    public let user: TwitterUserIdentifierV1

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/users/profile_banner.json"
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
