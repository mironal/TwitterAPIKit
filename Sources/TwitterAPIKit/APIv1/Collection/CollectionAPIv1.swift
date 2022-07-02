import Foundation

public protocol CollectionAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/get-collections-entries
    func getCollectionEntries(
        _ request: GetCollectionsEntriesRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/get-collections-list
    func getCollections(
        _ request: GetCollectionsListRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/get-collections-show
    func getCollection(
        _ request: GetCollectionsShowRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-create
    func postCreateCollection(
        _ request: PostCollectionsCreateRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-destroy
    func postDestroyCollection(
        _ request: PostCollectionsDestroyRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-entries-add
    func postCollectionAddEntry(
        _ request: PostCollectionsEntriesAddRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-entries-curate
    func postCollectionCurate(
        _ request: PostCollectionsEntriesCurateRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-entries-move
    func postCollectionMoveEntry(
        _ request: PostCollectionsEntriesMoveRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-entries-remove
    func postCollectionRemoveEntry(
        _ request: PostCollectionsEntriesRemoveRequestV1
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/curate-a-collection/api-reference/post-collections-update
    func postCollectionUpdate(
        _ request: PostCollectionsUpdateRequestV1
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIClient.TwitterAPIImplV1: CollectionAPIv1 {

    func getCollectionEntries(
        _ request: GetCollectionsEntriesRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getCollections(
        _ request: GetCollectionsListRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getCollection(
        _ request: GetCollectionsShowRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func postCreateCollection(
        _ request: PostCollectionsCreateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func postDestroyCollection(
        _ request: PostCollectionsDestroyRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func postCollectionAddEntry(
        _ request: PostCollectionsEntriesAddRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func postCollectionCurate(
        _ request: PostCollectionsEntriesCurateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func postCollectionMoveEntry(
        _ request: PostCollectionsEntriesMoveRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func postCollectionRemoveEntry(
        _ request: PostCollectionsEntriesRemoveRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func postCollectionUpdate(
        _ request: PostCollectionsUpdateRequestV1
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
