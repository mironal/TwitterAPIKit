import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-account-verify_credentials
open class GetAccountVerifyCredentialsRequestV1: TwitterAPIRequest {

    public let skipStatus: Bool?
    public let includeEmail: Bool?
    public let includeEntities: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/account/verify_credentials.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        skipStatus.map { p["skip_status"] = $0 }
        includeEmail.map { p["include_email"] = $0 }
        includeEntities.map { p["include_entities"] = $0 }
        return p
    }

    public init(
        skipStatus: Bool? = .none,
        includeEmail: Bool? = .none,
        includeEntities: Bool? = .none
    ) {
        self.skipStatus = skipStatus
        self.includeEmail = includeEmail
        self.includeEntities = includeEntities
    }
}
