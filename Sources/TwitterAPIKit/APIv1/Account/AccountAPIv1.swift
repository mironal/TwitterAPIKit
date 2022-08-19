import Foundation

open class AccountAPIv1: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-account-settings
    public func getAccountSetting(
        _ request: GetAccountSettingsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-account-verify_credentials
    public func getAccountVerify(
        _ request: GetAccountVerifyCredentialsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-remove_profile_banner
    public func postRemoveProfileBanner(
        _ request: PostAccountRemoveProfileBannerRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-settings
    public func postAccountSettings(
        _ request: PostAccountSettingsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile
    public func postAccountProfile(
        _ request: PostAccountUpdateProfileRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile_banner
    public func postProfileBanner(
        _ request: PostAccountUpdateProfileBannerRequestV1
    ) -> TwitterAPISessionDataTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile_image
    public func postProfileImage(
        _ request: PostAccountUpdateProfileImageRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
