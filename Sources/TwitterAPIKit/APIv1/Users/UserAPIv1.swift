import Foundation

open class UserAPIv1: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-users-lookup
    public func getUsers(
        _ request: GetUsersLookupRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-users-show
    public func getUser(
        _ request: GetUsersShowRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-users-search
    public func searchUser(
        _ request: GetUsersShowRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-users-profile_banner
    public func getUserProfileBanner(
        _ request: GetUsersProfileBannerRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
