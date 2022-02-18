import Foundation

public protocol SearchAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/search/api-reference/get-search-tweets
    @discardableResult
    func searchTweets(
        _ request: GetSearchTweetsRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/get-saved_searches-list
    @discardableResult
    func getSavedSearches(
        _ request: GetSavedSearchesListRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-saved_searches-create
    @discardableResult
    func postCreateSavedSearch(
        _ request: PostSavedSearchesCreateRequestV1
    ) -> TwitterAPISessionResponse

    /// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-saved_searches-destroy-id
    @discardableResult
    func postDestroySavedSearch(
        _ request: PostSavedSearchesCreateRequestV1
    ) -> TwitterAPISessionResponse

}

extension TwitterAPIKit.TwitterAPIImplV1: SearchAPIv1 {

    public func searchTweets(
        _ request: GetSearchTweetsRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func getSavedSearches(
        _ request: GetSavedSearchesListRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postCreateSavedSearch(
        _ request: PostSavedSearchesCreateRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }

    public func postDestroySavedSearch(
        _ request: PostSavedSearchesCreateRequestV1
    ) -> TwitterAPISessionResponse {
        return session.send(request)
    }
}
