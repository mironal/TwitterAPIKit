import Foundation

open class FavoriteAPIv1: TwitterAPIBase {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-favorites-create
    public func postFavorite(
        _ request: PostFavoriteRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-favorites-destroy
    public func postUnFavorite(
        _ request: PostUnFavoriteRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-favorites-list
    public func getFavorites(
        _ request: GetFavoritesRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
