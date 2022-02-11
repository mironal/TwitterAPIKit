import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-account-settings
open class GetAccountSettingsRequestV1: TwitterAPIRequest {

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/account/settings.json"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init() {
    }
}
