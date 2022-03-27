import Foundation

public protocol BookmarksAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/tweets/bookmarks/api-reference/get-users-id-bookmarks
    func getBookmarks(
        _ request: GetUsersBookmarksRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV2: BookmarksAPIv2 {

    func getBookmarks(_ request: GetUsersBookmarksRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
