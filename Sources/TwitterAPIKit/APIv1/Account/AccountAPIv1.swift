import Foundation

public protocol AccountAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-account-settings
    func getAccountSetting(
        _ request: GetAccountSettingsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-account-verify_credentials
    func getAccountVerify(
        _ request: GetAccountVerifyCredentialsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-remove_profile_banner
    func postRemoveProfileBanner(
        _ request: PostAccountRemoveProfileBannerRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-settings
    func postAccountSettings(
        _ request: PostAccountSettingsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile
    func postAccountProfile(
        _ request: PostAccountUpdateProfileRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile_banner
    func postProfileBanner(
        _ request: PostAccountUpdateProfileBannerRequestV1
    ) -> TwitterAPISessionDataTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile_image
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
    ) -> TwitterAPISessionDataTask {
        return session.send(request)
    }

    public func postProfileImage(
        _ request: PostAccountUpdateProfileImageRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
