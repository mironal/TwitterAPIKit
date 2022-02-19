import Foundation

public protocol FavoriteAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-favorites-create
    @discardableResult
    func postFavorite(
        _ request: PostFavoriteRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/post-favorites-destroy
    @discardableResult
    func postUnFavorite(
        _ request: PostUnFavoriteRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-favorites-list
    @discardableResult
    func getFavorites(
        _ request: GetFavoritesRequestV1
    ) -> TwitterAPISessionTask
}

extension TwitterAPIKit.TwitterAPIImplV1: FavoriteAPIv1 {

    public func getFavorites(
        _ request: GetFavoritesRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func postFavorite(
        _ request: PostFavoriteRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func postUnFavorite(
        _ request: PostUnFavoriteRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }
}
