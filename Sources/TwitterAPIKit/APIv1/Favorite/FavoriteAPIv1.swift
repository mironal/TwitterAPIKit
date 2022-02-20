import Foundation

public protocol FavoriteAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-favorites-create
    func postFavorite(
        _ request: PostFavoriteRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-favorites-destroy
    func postUnFavorite(
        _ request: PostUnFavoriteRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-favorites-list
    func getFavorites(
        _ request: GetFavoritesRequestV1
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV1: FavoriteAPIv1 {

    public func getFavorites(
        _ request: GetFavoritesRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postFavorite(
        _ request: PostFavoriteRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    public func postUnFavorite(
        _ request: PostUnFavoriteRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
