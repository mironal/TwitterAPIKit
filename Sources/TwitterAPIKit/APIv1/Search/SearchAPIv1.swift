import Foundation

public protocol SearchAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/search/api-reference/get-search-tweets
    func searchTweets(
        _ request: GetSearchTweetsRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-saved_searches-list
    func getSavedSearches(
        _ request: GetSavedSearchesListRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-saved_searches-create
    func postCreateSavedSearch(
        _ request: PostSavedSearchesCreateRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-saved_searches-destroy-id
    func postDestroySavedSearch(
        _ request: PostSavedSearchesCreateRequestV1
    ) -> TwitterAPISessionJSONTask

}

extension TwitterAPIKit.TwitterAPIImplV1: SearchAPIv1 {

    public func searchTweets(
        _ request: GetSearchTweetsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func getSavedSearches(
        _ request: GetSavedSearchesListRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postCreateSavedSearch(
        _ request: PostSavedSearchesCreateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postDestroySavedSearch(
        _ request: PostSavedSearchesCreateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
