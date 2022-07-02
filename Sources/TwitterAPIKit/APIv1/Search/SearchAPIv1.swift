import Foundation

open class SearchAPIv1: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/search/api-reference/get-search-tweets
    public func searchTweets(
        _ request: GetSearchTweetsRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-saved_searches-list
    public func getSavedSearches(
        _ request: GetSavedSearchesListRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-saved_searches-create
    public func postCreateSavedSearch(
        _ request: PostSavedSearchesCreateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-saved_searches-destroy-id
    public func postDestroySavedSearch(
        _ request: PostSavedSearchesCreateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
