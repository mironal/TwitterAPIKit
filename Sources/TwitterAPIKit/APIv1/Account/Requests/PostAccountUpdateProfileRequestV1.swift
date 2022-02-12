import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile
open class PostAccountUpdateProfileRequestV1: TwitterAPIRequest {

    public let url: String?
    public let name: String?
    public let location: String?
    public let skipStatus: Bool?
    public let description: String?
    public let includeEntities: Bool?
    /// ex) F00 , FF0000
    public let profileLinkColor: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/account/update_profile.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        url.map { p["url"] = $0 }
        name.map { p["name"] = $0 }
        location.map { p["location"] = $0 }
        skipStatus.map { p["skip_status"] = $0 }
        description.map { p["description"] = $0 }
        includeEntities.map { p["include_entities"] = $0 }
        profileLinkColor.map { p["profile_link_color"] = $0 }
        return p
    }

    public init(
        url: String? = .none,
        name: String? = .none,
        location: String? = .none,
        skipStatus: Bool? = .none,
        description: String? = .none,
        includeEntities: Bool? = .none,
        profileLinkColor: String? = .none
    ) {
        self.url = url
        self.name = name
        self.location = location
        self.skipStatus = skipStatus
        self.description = description
        self.includeEntities = includeEntities
        self.profileLinkColor = profileLinkColor
    }
}
