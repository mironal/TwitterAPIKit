import Foundation

public protocol UserAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-users-lookup
    func getUsers(
        _ request: GetUsersLookupRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-users-show
    func getUser(
        _ request: GetUsersShowRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-users-search
    func searchUser(
        _ request: GetUsersShowRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-users-profile_banner
    func getUserProfileBanner(
        _ request: GetUsersProfileBannerRequestV1
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV1: UserAPIv1 {

    public func getUsers(
        _ request: GetUsersLookupRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getUser(
        _ request: GetUsersShowRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func searchUser(
        _ request: GetUsersShowRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getUserProfileBanner(
        _ request: GetUsersProfileBannerRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
