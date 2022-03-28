import Foundation

public protocol BookmarksAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/bookmarks/api-reference/get-users-id-bookmarks
    func getBookmarks(
        _ request: GetUsersBookmarksRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/bookmarks/api-reference/post-users-id-bookmarks
    func createBookmark(
        _ request: PostUsersBookmarksRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/bookmarks/api-reference/delete-users-id-bookmarks-tweet_id
    func deleteBookmark(
        _ request: DeleteUsersBookmarksRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV2: BookmarksAPIv2 {

    func getBookmarks(_ request: GetUsersBookmarksRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func createBookmark(_ request: PostUsersBookmarksRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func deleteBookmark(_ request: DeleteUsersBookmarksRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
