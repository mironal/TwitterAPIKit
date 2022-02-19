import Foundation

public protocol CollectionAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/get-collections-entries
    @discardableResult
    func getCollectionEntries(
        _ request: GetCollectionsEntriesRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/get-collections-list
    @discardableResult
    func getCollections(
        _ request: GetCollectionsListRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/get-collections-show
    @discardableResult
    func getCollection(
        _ request: GetCollectionsShowRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-create
    @discardableResult
    func postCreateCollection(
        _ request: PostCollectionsCreateRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-destroy
    @discardableResult
    func postDestroyCollection(
        _ request: PostCollectionsDestroyRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-entries-add
    @discardableResult
    func postCollectionAddEntry(
        _ request: PostCollectionsEntriesAddRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-entries-curate
    @discardableResult
    func postCollectionCurate(
        _ request: PostCollectionsEntriesCurateRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-entries-move
    @discardableResult
    func postCollectionMoveEntry(
        _ request: PostCollectionsEntriesMoveRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-entries-remove
    @discardableResult
    func postCollectionRemoveEntry(
        _ request: PostCollectionsEntriesRemoveRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-update
    @discardableResult
    func postCollectionUpdate(
        _ request: PostCollectionsUpdateRequestV1
    ) -> TwitterAPISessionTask
}

extension TwitterAPIKit.TwitterAPIImplV1: CollectionAPIv1 {

    func getCollectionEntries(
        _ request: GetCollectionsEntriesRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    func getCollections(
        _ request: GetCollectionsListRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    func getCollection(
        _ request: GetCollectionsShowRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    func postCreateCollection(
        _ request: PostCollectionsCreateRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    func postDestroyCollection(
        _ request: PostCollectionsDestroyRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    func postCollectionAddEntry(
        _ request: PostCollectionsEntriesAddRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    func postCollectionCurate(
        _ request: PostCollectionsEntriesCurateRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    func postCollectionMoveEntry(
        _ request: PostCollectionsEntriesMoveRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    func postCollectionRemoveEntry(
        _ request: PostCollectionsEntriesRemoveRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    func postCollectionUpdate(
        _ request: PostCollectionsUpdateRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }
}
