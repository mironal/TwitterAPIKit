import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-remove_profile_banner
open class PostAccountRemoveProfileBannerRequestV1: TwitterAPIRequest {

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/account/remove_profile_banner.json"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init() {}
}
