import Foundation

public protocol AccountAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-account-settings
    @discardableResult
    func getAccountSetting(
        _ request: GetAccountSettingsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-account-verify_credentials
    @discardableResult
    func getAccountVerify(
        _ request: GetAccountVerifyCredentialsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-remove_profile_banner
    @discardableResult
    func postRemoveProfileBanner(
        _ request: PostAccountRemoveProfileBannerRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-settings
    @discardableResult
    func postAccountSettings(
        _ request: PostAccountSettingsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile
    @discardableResult
    func postAccountProfile(
        _ request: PostAccountUpdateProfileRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile_banner
    @discardableResult
    func postProfileBanner(
        _ request: PostAccountUpdateProfileBannerRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile_image
    @discardableResult
    func postProfileImage(
        _ request: PostAccountUpdateProfileImageRequestV1
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV1: AccountAPIv1 {
    public func getAccountSetting(
        _ request: GetAccountSettingsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getAccountVerify(
        _ request: GetAccountVerifyCredentialsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postRemoveProfileBanner(
        _ request: PostAccountRemoveProfileBannerRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postAccountSettings(
        _ request: PostAccountSettingsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
    public func postAccountProfile(
        _ request: PostAccountUpdateProfileRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postProfileBanner(
        _ request: PostAccountUpdateProfileBannerRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postProfileImage(
        _ request: PostAccountUpdateProfileImageRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
