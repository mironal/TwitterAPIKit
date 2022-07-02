import Foundation

public protocol UserAPIv2 {
    /// https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-id
    func getUser(
        _ request: GetUserRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users
    func getUsers(
        _ request: GetUsersRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by-username-username
    func getUserByUsername(
        _ request: GetUsersByUsernameRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by
    func getUsersByUsernames(
        _ request: GetUsersByRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-me
    func getMe(
        _ request: GetUsersMeRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIClient.TwitterAPIImplV2: UserAPIv2 {

    func getUser(_ request: GetUserRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getUsers(_ request: GetUsersRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getUserByUsername(_ request: GetUsersByUsernameRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getUsersByUsernames(_ request: GetUsersByRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getMe(_ request: GetUsersMeRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
