import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile_banner
open class PostAccountUpdateProfileBannerRequestV1: TwitterAPIRequest {

    public let banner: Data
    public let width: Int?
    public let height: Int?
    public let offsetTop: Int?
    public let offsetLeft: Int?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/account/update_profile_banner.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["banner"] = banner.base64EncodedString()
        width.map { p["width"] = $0 }
        height.map { p["height"] = $0 }
        offsetTop.map { p["offset_top"] = $0 }
        offsetLeft.map { p["offset_left"] = $0 }
        return p
    }

    public init(
        banner: Data,
        width: Int? = .none,
        height: Int? = .none,
        offsetTop: Int? = .none,
        offsetLeft: Int? = .none
    ) {
        self.banner = banner
        self.width = width
        self.height = height
        self.offsetTop = offsetTop
        self.offsetLeft = offsetLeft
    }

}
