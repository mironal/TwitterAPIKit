import Foundation

public protocol AccountAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-account-settings
    @discardableResult
    func getAccountSetting(
        _ request: GetAccountSettingsRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-account-verify_credentials
    @discardableResult
    func getAccountVerify(
        _ request: GetAccountVerifyCredentialsRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-remove_profile_banner
    @discardableResult
    func postRemoveProfileBanner(
        _ request: PostAccountRemoveProfileBannerRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-settings
    @discardableResult
    func postAccountSettings(
        _ request: PostAccountSettingsRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile
    @discardableResult
    func postAccountProfile(
        _ request: PostAccountUpdateProfileRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile_banner
    @discardableResult
    func postProfileBanner(
        _ request: PostAccountUpdateProfileBannerRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile_image
    @discardableResult
    func postProfileImage(
        _ request: PostAccountUpdateProfileImageRequestV1
    ) -> TwitterAPISessionResponse
}

extension TwitterAPIKit.TwitterAPIImplV1: AccountAPIv1 {
    public func getAccountSetting(
        _ request: GetAccountSettingsRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getAccountVerify(
        _ request: GetAccountVerifyCredentialsRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postRemoveProfileBanner(
        _ request: PostAccountRemoveProfileBannerRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postAccountSettings(
        _ request: PostAccountSettingsRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }
    public func postAccountProfile(
        _ request: PostAccountUpdateProfileRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postProfileBanner(
        _ request: PostAccountUpdateProfileBannerRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postProfileImage(
        _ request: PostAccountUpdateProfileImageRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }
}
