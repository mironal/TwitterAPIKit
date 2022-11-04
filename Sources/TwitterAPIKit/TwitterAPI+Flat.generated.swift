// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swift-format-ignore-file
import Foundation

extension TwitterAuthAPI {

    // MARK: - OAuth10aAPI

    public func postOAuthRequestTokenData(_ request: PostOAuthRequestTokenRequestV1) -> TwitterAPISessionDataTask {
        return oauth10a.postOAuthRequestTokenData(request)
    }
    public func postOAuthRequestToken(_ request: PostOAuthRequestTokenRequestV1) -> TwitterAPISessionSpecializedTask<TwitterOAuthTokenV1> {
        return oauth10a.postOAuthRequestToken(request)
    }
    public func makeOAuthAuthorizeURL(_ request: GetOAuthAuthorizeRequestV1) -> URL? {
        return oauth10a.makeOAuthAuthorizeURL(request)
    }
    public func makeOAuthAuthenticateURL(_ request: GetOAuthAuthenticateRequestV1) -> URL? {
        return oauth10a.makeOAuthAuthenticateURL(request)
    }
    public func postOAuthAccessTokenData(_ request: PostOAuthAccessTokenRequestV1) -> TwitterAPISessionDataTask {
        return oauth10a.postOAuthAccessTokenData(request)
    }
    public func postOAuthAccessToken(_ request: PostOAuthAccessTokenRequestV1) -> TwitterAPISessionSpecializedTask<TwitterOAuthAccessTokenV1> {
        return oauth10a.postOAuthAccessToken(request)
    }
    public func postInvalidateAccessToken(_ request: PostOAuthInvalidateTokenRequestV1) -> TwitterAPISessionJSONTask {
        return oauth10a.postInvalidateAccessToken(request)
    }

    // MARK: - OAuth20API

    public func postOAuth2BearerTokenData(_ request: PostOAuth2TokenRequestV1) -> TwitterAPISessionDataTask {
        return oauth20.postOAuth2BearerTokenData(request)
    }
    public func postOAuth2BearerToken(_ request: PostOAuth2TokenRequestV1) -> TwitterAPISessionSpecializedTask<TwitterOAuth2BearerToken> {
        return oauth20.postOAuth2BearerToken(request)
    }
    public func postInvalidateOAuth2BearerToken(_ request: PostOAuth2InvalidateTokenRequestV1) -> TwitterAPISessionJSONTask {
        return oauth20.postInvalidateOAuth2BearerToken(request)
    }
    public func makeOAuth2AuthorizeURL(_ request: GetOAuth2AuthorizeRequestV1) -> URL? {
        return oauth20.makeOAuth2AuthorizeURL(request)
    }
    public func postOAuth2AccessTokenData(_ request: PostOAuth2AccessTokenRequestV2) -> TwitterAPISessionDataTask {
        return oauth20.postOAuth2AccessTokenData(request)
    }
    public func postOAuth2AccessToken(_ request: PostOAuth2AccessTokenRequestV2) -> TwitterAPISessionSpecializedTask<TwitterOAuth2AccessToken> {
        return oauth20.postOAuth2AccessToken(request)
    }
    public func postOAuth2RefreshTokenData(_ request: PostOAuth2RefreshTokenRequestV2) -> TwitterAPISessionDataTask {
        return oauth20.postOAuth2RefreshTokenData(request)
    }
    public func postOAuth2RefreshToken(_ request: PostOAuth2RefreshTokenRequestV2) -> TwitterAPISessionSpecializedTask<TwitterOAuth2AccessToken> {
        return oauth20.postOAuth2RefreshToken(request)
    }
    public func postOAuth2RevokeToken(_ request: PostOAuth2RevokeTokenRequestV2) -> TwitterAPISessionDataTask {
        return oauth20.postOAuth2RevokeToken(request)
    }
}

extension TwitterAPIv1 {

    // MARK: - AccountAPIv1

    public func getAccountSetting(_ request: GetAccountSettingsRequestV1) -> TwitterAPISessionJSONTask {
        return account.getAccountSetting(request)
    }
    public func getAccountVerify(_ request: GetAccountVerifyCredentialsRequestV1) -> TwitterAPISessionJSONTask {
        return account.getAccountVerify(request)
    }
    public func postRemoveProfileBanner(_ request: PostAccountRemoveProfileBannerRequestV1) -> TwitterAPISessionJSONTask {
        return account.postRemoveProfileBanner(request)
    }
    public func postAccountSettings(_ request: PostAccountSettingsRequestV1) -> TwitterAPISessionJSONTask {
        return account.postAccountSettings(request)
    }
    public func postAccountProfile(_ request: PostAccountUpdateProfileRequestV1) -> TwitterAPISessionJSONTask {
        return account.postAccountProfile(request)
    }
    public func postProfileBanner(_ request: PostAccountUpdateProfileBannerRequestV1) -> TwitterAPISessionDataTask {
        return account.postProfileBanner(request)
    }
    public func postProfileImage(_ request: PostAccountUpdateProfileImageRequestV1) -> TwitterAPISessionJSONTask {
        return account.postProfileImage(request)
    }

    // MARK: - ApplicationAPIv1

    public func getRateLimit(_ request: GetApplicationRateLimitStatusRequestV1) -> TwitterAPISessionJSONTask {
        return application.getRateLimit(request)
    }

    // MARK: - BlockAndMuteAPIv1

    public func getBlockIDs(_ request: GetBlocksIDsRequestV1) -> TwitterAPISessionJSONTask {
        return blockAndMute.getBlockIDs(request)
    }
    public func getBlockUsers(_ request: GetBlocksListRequestV1) -> TwitterAPISessionJSONTask {
        return blockAndMute.getBlockUsers(request)
    }
    public func getMuteIDs(_ request: GetMutesUsersIDsRequestV1) -> TwitterAPISessionJSONTask {
        return blockAndMute.getMuteIDs(request)
    }
    public func getMuteUsers(_ request: GetMutesUsersListRequestV1) -> TwitterAPISessionJSONTask {
        return blockAndMute.getMuteUsers(request)
    }
    public func postBlockUser(_ request: PostBlocksCreateRequestV1) -> TwitterAPISessionJSONTask {
        return blockAndMute.postBlockUser(request)
    }
    public func postUnblockUser(_ request: PostBlocksDestroyRequestV1) -> TwitterAPISessionJSONTask {
        return blockAndMute.postUnblockUser(request)
    }
    public func postMuteUser(_ request: PostMutesUsersCreateRequestV1) -> TwitterAPISessionJSONTask {
        return blockAndMute.postMuteUser(request)
    }
    public func postUnmuteUser(_ request: PostMutesUsersDestroyRequestV1) -> TwitterAPISessionJSONTask {
        return blockAndMute.postUnmuteUser(request)
    }
    public func postReportSpam(_ request: PostUsersReportSpamRequestV1) -> TwitterAPISessionJSONTask {
        return blockAndMute.postReportSpam(request)
    }

    // MARK: - CollectionAPIv1

    public func getCollectionEntries(_ request: GetCollectionsEntriesRequestV1) -> TwitterAPISessionJSONTask {
        return collection.getCollectionEntries(request)
    }
    public func getCollections(_ request: GetCollectionsListRequestV1) -> TwitterAPISessionJSONTask {
        return collection.getCollections(request)
    }
    public func getCollection(_ request: GetCollectionsShowRequestV1) -> TwitterAPISessionJSONTask {
        return collection.getCollection(request)
    }
    public func postCreateCollection(_ request: PostCollectionsCreateRequestV1) -> TwitterAPISessionJSONTask {
        return collection.postCreateCollection(request)
    }
    public func postDestroyCollection(_ request: PostCollectionsDestroyRequestV1) -> TwitterAPISessionJSONTask {
        return collection.postDestroyCollection(request)
    }
    public func postCollectionAddEntry(_ request: PostCollectionsEntriesAddRequestV1) -> TwitterAPISessionJSONTask {
        return collection.postCollectionAddEntry(request)
    }
    public func postCollectionCurate(_ request: PostCollectionsEntriesCurateRequestV1) -> TwitterAPISessionJSONTask {
        return collection.postCollectionCurate(request)
    }
    public func postCollectionMoveEntry(_ request: PostCollectionsEntriesMoveRequestV1) -> TwitterAPISessionJSONTask {
        return collection.postCollectionMoveEntry(request)
    }
    public func postCollectionRemoveEntry(_ request: PostCollectionsEntriesRemoveRequestV1) -> TwitterAPISessionJSONTask {
        return collection.postCollectionRemoveEntry(request)
    }
    public func postCollectionUpdate(_ request: PostCollectionsUpdateRequestV1) -> TwitterAPISessionJSONTask {
        return collection.postCollectionUpdate(request)
    }

    // MARK: - DirectMessageAPIv1

    public func postDirectMessage(_ request: PostDirectMessageRequestV1) -> TwitterAPISessionJSONTask {
        return directMessage.postDirectMessage(request)
    }
    public func deleteDirectMessage(_ request: DeleteDirectMessageRequestV1) -> TwitterAPISessionDataTask {
        return directMessage.deleteDirectMessage(request)
    }
    public func getDirectMessage(_ request: GetDirectMessageRequestV1) -> TwitterAPISessionJSONTask {
        return directMessage.getDirectMessage(request)
    }
    public func getDirectMessageList(_ request: GetDirectMessageListRequestV1) -> TwitterAPISessionJSONTask {
        return directMessage.getDirectMessageList(request)
    }
    public func postDirectMessageMarkRead(_ request: PostDirectMessagesMarkReadRequestV1) -> TwitterAPISessionDataTask {
        return directMessage.postDirectMessageMarkRead(request)
    }
    public func postDirectMessageTypingIndicator(_ request: PostDirectMessagesIndicateTypingRequestV1) -> TwitterAPISessionDataTask {
        return directMessage.postDirectMessageTypingIndicator(request)
    }

    // MARK: - FavoriteAPIv1

    public func postFavorite(_ request: PostFavoriteRequestV1) -> TwitterAPISessionJSONTask {
        return favorite.postFavorite(request)
    }
    public func postUnFavorite(_ request: PostUnFavoriteRequestV1) -> TwitterAPISessionJSONTask {
        return favorite.postUnFavorite(request)
    }
    public func getFavorites(_ request: GetFavoritesRequestV1) -> TwitterAPISessionJSONTask {
        return favorite.getFavorites(request)
    }

    // MARK: - FriendshipsAPIv1

    public func getFollowerIDs(_ request: GetFollowersIDsRequestV1) -> TwitterAPISessionJSONTask {
        return friendships.getFollowerIDs(request)
    }
    public func getFollowers(_ request: GetFollowersListRequestV1) -> TwitterAPISessionJSONTask {
        return friendships.getFollowers(request)
    }
    public func getFriendIDs(_ request: GetFriendsIDsRequestV1) -> TwitterAPISessionJSONTask {
        return friendships.getFriendIDs(request)
    }
    public func getFriends(_ request: GetFriendsListRequestV1) -> TwitterAPISessionJSONTask {
        return friendships.getFriends(request)
    }
    public func getFriendshipsIncoming(_ request: GetFriendshipsIncomingRequestV1) -> TwitterAPISessionJSONTask {
        return friendships.getFriendshipsIncoming(request)
    }
    public func getFriendshipsLookup(_ request: GetFriendshipsLookupRequestV1) -> TwitterAPISessionJSONTask {
        return friendships.getFriendshipsLookup(request)
    }
    public func getFriendshipsNoRetweetsIDs(_ request: GetFriendshipsNoRetweetsIDsRequestV1) -> TwitterAPISessionJSONTask {
        return friendships.getFriendshipsNoRetweetsIDs(request)
    }
    public func getFriendshipsOutgoing(_ request: GetFriendshipsOutgoingRequestV1) -> TwitterAPISessionJSONTask {
        return friendships.getFriendshipsOutgoing(request)
    }
    public func getFriendships(_ request: GetFriendshipsShowRequestV1) -> TwitterAPISessionJSONTask {
        return friendships.getFriendships(request)
    }
    public func postFollowUser(_ request: PostFriendshipsCreateRequestV1) -> TwitterAPISessionJSONTask {
        return friendships.postFollowUser(request)
    }
    public func postUnfollowUser(_ request: PostFriendshipsDestroyRequestV1) -> TwitterAPISessionJSONTask {
        return friendships.postUnfollowUser(request)
    }
    public func postFriendshipsUpdate(_ request: PostFriendshipsUpdateRequestV1) -> TwitterAPISessionJSONTask {
        return friendships.postFriendshipsUpdate(request)
    }

    // MARK: - GeoAPIv1

    public func getReverseGeocode(_ request: GetGeoReverseGeocodeRequestV1) -> TwitterAPISessionJSONTask {
        return geo.getReverseGeocode(request)
    }
    public func getGeoPlace(_ request: GetGeoPlaceIDRequestV1) -> TwitterAPISessionJSONTask {
        return geo.getGeoPlace(request)
    }
    public func searchGeo(_ request: GetGeoSearchRequestV1) -> TwitterAPISessionJSONTask {
        return geo.searchGeo(request)
    }

    // MARK: - HelpAPIv1

    public func getSupportedLanguages(_ request: GetHelpLanguagesRequestV1) -> TwitterAPISessionJSONTask {
        return help.getSupportedLanguages(request)
    }

    // MARK: - ListAPIv1

    public func getLists(_ request: GetListsListRequestV1) -> TwitterAPISessionJSONTask {
        return list.getLists(request)
    }
    public func getListMembers(_ request: GetListsMembersRequestV1) -> TwitterAPISessionJSONTask {
        return list.getListMembers(request)
    }
    public func getListMember(_ request: GetListsMembersShowRequestV1) -> TwitterAPISessionJSONTask {
        return list.getListMember(request)
    }
    public func getListMemberships(_ request: GetListsMembershipsRequestV1) -> TwitterAPISessionJSONTask {
        return list.getListMemberships(request)
    }
    public func getListOwnerships(_ request: GetListsOwnershipsRequestV1) -> TwitterAPISessionJSONTask {
        return list.getListOwnerships(request)
    }
    public func getList(_ request: GetListsShowRequestV1) -> TwitterAPISessionJSONTask {
        return list.getList(request)
    }
    public func getListStatuses(_ request: GetListsStatusesRequestV1) -> TwitterAPISessionJSONTask {
        return list.getListStatuses(request)
    }
    public func getListSubscribers(_ request: GetListsSubscribersRequestV1) -> TwitterAPISessionJSONTask {
        return list.getListSubscribers(request)
    }
    public func getListSubscriber(_ request: GetListsSubscribersShowRequestV1) -> TwitterAPISessionJSONTask {
        return list.getListSubscriber(request)
    }
    public func getListSubscriptions(_ request: GetListsSubscriptionsRequestV1) -> TwitterAPISessionJSONTask {
        return list.getListSubscriptions(request)
    }
    public func postCreateList(_ request: PostListsCreateRequestV1) -> TwitterAPISessionJSONTask {
        return list.postCreateList(request)
    }
    public func postDestroyList(_ request: PostListsDestroyRequestV1) -> TwitterAPISessionJSONTask {
        return list.postDestroyList(request)
    }
    public func postAddListMember(_ request: PostListsMembersCreateRequestV1) -> TwitterAPISessionJSONTask {
        return list.postAddListMember(request)
    }
    public func postAddListMembers(_ request: PostListsMembersCreateAllRequestV1) -> TwitterAPISessionJSONTask {
        return list.postAddListMembers(request)
    }
    public func postRemoveListMember(_ request: PostListsMembersDestroyRequestV1) -> TwitterAPISessionJSONTask {
        return list.postRemoveListMember(request)
    }
    public func postRemoveListMembers(_ request: PostListsMembersDestroyAllRequestV1) -> TwitterAPISessionJSONTask {
        return list.postRemoveListMembers(request)
    }
    public func postSubscribeList(_ request: PostListsSubscribersCreateRequestV1) -> TwitterAPISessionJSONTask {
        return list.postSubscribeList(request)
    }
    public func postUnsubscribeList(_ request: PostListsSubscribersDestroyRequestV1) -> TwitterAPISessionJSONTask {
        return list.postUnsubscribeList(request)
    }
    public func postUpdateList(_ request: PostListsUpdateRequestV1) -> TwitterAPISessionJSONTask {
        return list.postUpdateList(request)
    }

    // MARK: - MediaAPIv1

    public func getUploadMediaStatus(_ request: GetUploadMediaStatusRequestV1) -> TwitterAPISessionJSONTask {
        return media.getUploadMediaStatus(request)
    }
    public func uploadMediaInit(_ request: UploadMediaInitRequestV1) -> TwitterAPISessionJSONTask {
        return media.uploadMediaInit(request)
    }
    public func uploadMediaAppend(_ request: UploadMediaAppendRequestV1) -> TwitterAPISessionJSONTask {
        return media.uploadMediaAppend(request)
    }
    public func uploadMediaAppendSplitChunks(_ request: UploadMediaAppendRequestV1, maxBytes: Int = 5_242_880) -> [TwitterAPISessionSpecializedTask<String /* mediaID */>] {
        return media.uploadMediaAppendSplitChunks(request, maxBytes: maxBytes)
    }
    public func uploadMediaFinalize(_ request: UploadMediaFinalizeRequestV1) -> TwitterAPISessionJSONTask {
        return media.uploadMediaFinalize(request)
    }
    public func uploadMedia(_ parameters: UploadMediaRequestParameters, completionHandler: @escaping (TwitterAPIResponse<String>) -> Void) {
        media.uploadMedia(parameters, completionHandler: completionHandler)
    }
    public func waitMediaProcessing(mediaID: String, initialWaitSec: Int, completionHandler: @escaping (TwitterAPIResponse<TwitterAPIClient.UploadMediaStatusResponse>) -> Void) {
        media.waitMediaProcessing(mediaID: mediaID, initialWaitSec: initialWaitSec, completionHandler: completionHandler)
    }
    public func waitMediaProcessing(mediaID: String, completionHandler: @escaping (TwitterAPIResponse<TwitterAPIClient.UploadMediaStatusResponse>) -> Void) {
        media.waitMediaProcessing(mediaID: mediaID, completionHandler: completionHandler)
    }
    public func createMediaMetadata(_ request: PostMediaMetadataCreateRequestV1) -> TwitterAPISessionDataTask {
        return media.createMediaMetadata(request)
    }
    public func createSubtitle(_ request: PostMediaSubtitlesCreateRequestV1) -> TwitterAPISessionDataTask {
        return media.createSubtitle(request)
    }
    public func deleteSubtitle(_ request: PostMediaSubtitlesDeleteRequestV1) -> TwitterAPISessionDataTask {
        return media.deleteSubtitle(request)
    }

    // MARK: - RetweetAPIv1

    public func postRetweet(_ request: PostRetweetRequestV1) -> TwitterAPISessionJSONTask {
        return retweet.postRetweet(request)
    }
    public func postUnRetweet(_ request: PostUnRetweetRequestV1) -> TwitterAPISessionJSONTask {
        return retweet.postUnRetweet(request)
    }
    public func getRetweets(_ request: GetRetweetsRequestV1) -> TwitterAPISessionJSONTask {
        return retweet.getRetweets(request)
    }
    public func getRetweetsOfMe(_ request: GetRetweetsOfMeRequestV1) -> TwitterAPISessionJSONTask {
        return retweet.getRetweetsOfMe(request)
    }
    public func getRetweeters(_ request: GetRetweetersRequestV1) -> TwitterAPISessionJSONTask {
        return retweet.getRetweeters(request)
    }

    // MARK: - SearchAPIv1

    public func searchTweets(_ request: GetSearchTweetsRequestV1) -> TwitterAPISessionJSONTask {
        return search.searchTweets(request)
    }
    public func getSavedSearches(_ request: GetSavedSearchesListRequestV1) -> TwitterAPISessionJSONTask {
        return search.getSavedSearches(request)
    }
    public func postCreateSavedSearch(_ request: PostSavedSearchesCreateRequestV1) -> TwitterAPISessionJSONTask {
        return search.postCreateSavedSearch(request)
    }
    public func postDestroySavedSearch(_ request: PostSavedSearchesCreateRequestV1) -> TwitterAPISessionJSONTask {
        return search.postDestroySavedSearch(request)
    }

    // MARK: - TimelineAPIv1

    public func getHomeTimeline(_ request: GetStatusesHomeTimelineRequestV1) -> TwitterAPISessionJSONTask {
        return timeline.getHomeTimeline(request)
    }
    public func getMentionsTimeline(_ request: GetStatusesMentionsTimelineRequestV1) -> TwitterAPISessionJSONTask {
        return timeline.getMentionsTimeline(request)
    }
    public func getUserTimeline(_ request: GetStatusesUserTimelineRequestV1) -> TwitterAPISessionJSONTask {
        return timeline.getUserTimeline(request)
    }

    // MARK: - TrendAPIv1

    public func getTrendsAvailable(_ request: GetTrendsAvailableRequestV1) -> TwitterAPISessionJSONTask {
        return trend.getTrendsAvailable(request)
    }
    public func getTrendsClosest(_ request: GetTrendsClosestRequestV1) -> TwitterAPISessionJSONTask {
        return trend.getTrendsClosest(request)
    }
    public func getTrends(_ request: GetTrendsPlaceRequestV1) -> TwitterAPISessionJSONTask {
        return trend.getTrends(request)
    }

    // MARK: - TweetAPIv1

    public func postUpdateStatus(_ request: PostStatusesUpdateRequestV1) -> TwitterAPISessionJSONTask {
        return tweet.postUpdateStatus(request)
    }
    public func postDestroyStatus(_ request: PostStatusesDestroyRequestV1) -> TwitterAPISessionJSONTask {
        return tweet.postDestroyStatus(request)
    }
    public func getShowStatus(_ request: GetStatusesShowRequestV1) -> TwitterAPISessionJSONTask {
        return tweet.getShowStatus(request)
    }
    public func getLookupStatuses(_ request: GetStatusesLookupRequestV1) -> TwitterAPISessionJSONTask {
        return tweet.getLookupStatuses(request)
    }

    // MARK: - UserAPIv1

    public func getUsers(_ request: GetUsersLookupRequestV1) -> TwitterAPISessionJSONTask {
        return user.getUsers(request)
    }
    public func getUser(_ request: GetUsersShowRequestV1) -> TwitterAPISessionJSONTask {
        return user.getUser(request)
    }
    public func searchUser(_ request: GetUsersShowRequestV1) -> TwitterAPISessionJSONTask {
        return user.searchUser(request)
    }
    public func getUserProfileBanner(_ request: GetUsersProfileBannerRequestV1) -> TwitterAPISessionJSONTask {
        return user.getUserProfileBanner(request)
    }
}

extension TwitterAPIv2 {

    // MARK: - BlockAndMuteAPIv2

    public func getBlockUsers(_ request: GetUsersBlockingRequestV2) -> TwitterAPISessionJSONTask {
        return blockAndMute.getBlockUsers(request)
    }
    public func blockUser(_ request: PostUsersBlockingRequestV2) -> TwitterAPISessionJSONTask {
        return blockAndMute.blockUser(request)
    }
    public func unblockUser(_ request: DeleteUsersBlockingRequestV2) -> TwitterAPISessionJSONTask {
        return blockAndMute.unblockUser(request)
    }
    public func getMuteUsers(_ request: GetUsersMutingRequestV2) -> TwitterAPISessionJSONTask {
        return blockAndMute.getMuteUsers(request)
    }
    public func muteUser(_ request: PostUsersMutingRequestV2) -> TwitterAPISessionJSONTask {
        return blockAndMute.muteUser(request)
    }
    public func unmuteUser(_ request: DeleteUsersMutingRequestV2) -> TwitterAPISessionJSONTask {
        return blockAndMute.unmuteUser(request)
    }

    // MARK: - BookmarksAPIv2

    public func getBookmarks(_ request: GetUsersBookmarksRequestV2) -> TwitterAPISessionJSONTask {
        return bookmarks.getBookmarks(request)
    }
    public func createBookmark(_ request: PostUsersBookmarksRequestV2) -> TwitterAPISessionJSONTask {
        return bookmarks.createBookmark(request)
    }
    public func deleteBookmark(_ request: DeleteUsersBookmarksRequestV2) -> TwitterAPISessionJSONTask {
        return bookmarks.deleteBookmark(request)
    }

    // MARK: - ComplianceAPIv2

    public func getComplianceJob(_ request: GetComplianceJobRequestV2) -> TwitterAPISessionJSONTask {
        return compliance.getComplianceJob(request)
    }
    public func getComplianceJobj(_ request: GetComplianceJobsRequestV2) -> TwitterAPISessionJSONTask {
        return compliance.getComplianceJobj(request)
    }
    public func createComplianceJob(_ request: PostComplianceJobsRequestV2) -> TwitterAPISessionJSONTask {
        return compliance.createComplianceJob(request)
    }

    // MARK: - FriendshipsAPIv2

    public func getFollowing(_ request: GetUsersFollowingRequestV2) -> TwitterAPISessionJSONTask {
        return friendships.getFollowing(request)
    }
    public func getFollowers(_ request: GetUsersFollowersRequestV2) -> TwitterAPISessionJSONTask {
        return friendships.getFollowers(request)
    }
    public func follow(_ request: PostUsersFollowingRequestV2) -> TwitterAPISessionJSONTask {
        return friendships.follow(request)
    }
    public func unfollow(_ request: DeleteUsersFollowingRequestV2) -> TwitterAPISessionJSONTask {
        return friendships.unfollow(request)
    }

    // MARK: - LikeAPIv2

    public func getLikingUsers(_ request: GetTweetsLikingUsersRequestV2) -> TwitterAPISessionJSONTask {
        return like.getLikingUsers(request)
    }
    public func getLikedTweets(_ request: GetUsersLikedTweetsRequestV2) -> TwitterAPISessionJSONTask {
        return like.getLikedTweets(request)
    }
    public func postLike(_ request: PostUsersLikesRequestV2) -> TwitterAPISessionJSONTask {
        return like.postLike(request)
    }
    public func deleteLike(_ request: DeleteUsersLikesRequestV2) -> TwitterAPISessionJSONTask {
        return like.deleteLike(request)
    }

    // MARK: - ListAPIv2

    public func getListTweets(_ request: GetListsTweetsRequestV2) -> TwitterAPISessionJSONTask {
        return list.getListTweets(request)
    }
    public func getList(_ request: GetListRequestV2) -> TwitterAPISessionJSONTask {
        return list.getList(request)
    }
    public func getLists(_ request: GetUsersOwnedListsRequestV2) -> TwitterAPISessionJSONTask {
        return list.getLists(request)
    }
    public func followList(_ request: PostUsersFollowedListsRequestV2) -> TwitterAPISessionJSONTask {
        return list.followList(request)
    }
    public func unfollowList(_ request: DeleteUsersFollowedListsRequestV2) -> TwitterAPISessionJSONTask {
        return list.unfollowList(request)
    }
    public func listFollowers(_ request: GetListsFollowersRequestV2) -> TwitterAPISessionJSONTask {
        return list.listFollowers(request)
    }
    public func followedLists(_ request: GetUsersFollowedListsRequestV2) -> TwitterAPISessionJSONTask {
        return list.followedLists(request)
    }
    public func addListMember(_ request: PostListsMembersRequestV2) -> TwitterAPISessionJSONTask {
        return list.addListMember(request)
    }
    public func removeListMember(_ request: DeleteListsMembersRequestV2) -> TwitterAPISessionJSONTask {
        return list.removeListMember(request)
    }
    public func getListMemberships(_ request: GetUsersListMembershipsRequestV2) -> TwitterAPISessionJSONTask {
        return list.getListMemberships(request)
    }
    public func getListMembers(_ request: GetListsMembersRequestV2) -> TwitterAPISessionJSONTask {
        return list.getListMembers(request)
    }
    public func createList(_ request: PostListsRequestV2) -> TwitterAPISessionJSONTask {
        return list.createList(request)
    }
    public func updateList(_ request: PutListRequestV2) -> TwitterAPISessionJSONTask {
        return list.updateList(request)
    }
    public func deleteList(_ request: DeleteListRequestV2) -> TwitterAPISessionJSONTask {
        return list.deleteList(request)
    }
    public func pinnedList(_ request: GetUsersPinnedListsRequestV2) -> TwitterAPISessionJSONTask {
        return list.pinnedList(request)
    }
    public func pinList(_ request: PostUsersPinnedListsRequestV2) -> TwitterAPISessionJSONTask {
        return list.pinList(request)
    }
    public func unpinList(_ request: DeleteUsersPinnedListsRequestV2) -> TwitterAPISessionJSONTask {
        return list.unpinList(request)
    }

    // MARK: - RetweetAPIv2

    public func getRetweetedBy(_ request: GetTweetsRetweetedByRequestV2) -> TwitterAPISessionJSONTask {
        return retweet.getRetweetedBy(request)
    }
    public func postRetweet(_ request: PostUsersRetweetsRequestV2) -> TwitterAPISessionJSONTask {
        return retweet.postRetweet(request)
    }
    public func deleteRetweet(_ request: DeleteUsersRetweetsRequestV2) -> TwitterAPISessionJSONTask {
        return retweet.deleteRetweet(request)
    }

    // MARK: - SearchAPIv2

    public func searchTweetsRecent(_ request: GetTweetsSearchRecentRequestV2) -> TwitterAPISessionJSONTask {
        return search.searchTweetsRecent(request)
    }
    public func searchTweetsAll(_ request: GetTweetsSearchAllRequestV2) -> TwitterAPISessionJSONTask {
        return search.searchTweetsAll(request)
    }

    // MARK: - SpacesAPIv2

    public func getSpace(_ request: GetSpaceRequestV2) -> TwitterAPISessionJSONTask {
        return spaces.getSpace(request)
    }
    public func getSpaces(_ request: GetSpacesRequestV2) -> TwitterAPISessionJSONTask {
        return spaces.getSpaces(request)
    }
    public func getSpacesByCreators(_ request: GetSpacesByCreatorIDsRequestV2) -> TwitterAPISessionJSONTask {
        return spaces.getSpacesByCreators(request)
    }
    public func getSpacesBuyers(_ request: GetSpacesBuyersRequestV2) -> TwitterAPISessionJSONTask {
        return spaces.getSpacesBuyers(request)
    }
    public func getSPacesTweets(_ request: GetSpacesTweetsRequestV2) -> TwitterAPISessionJSONTask {
        return spaces.getSPacesTweets(request)
    }
    public func searchSpaces(_ request: GetSpacesSearchRequestV2) -> TwitterAPISessionJSONTask {
        return spaces.searchSpaces(request)
    }

    // MARK: - StreamAPIv2

    public func sampleStream(_ request: GetTweetsSampleStreamRequestV2) -> TwitterAPISessionStreamTask {
        return stream.sampleStream(request)
    }
    public func getSearchStreamRules(_ request: GetTweetsSearchStreamRulesRequestV2) -> TwitterAPISessionJSONTask {
        return stream.getSearchStreamRules(request)
    }
    public func postSearchStreamRules(_ request: PostTweetsSearchStreamRulesRequestV2) -> TwitterAPISessionJSONTask {
        return stream.postSearchStreamRules(request)
    }
    public func searchStream(_ request: GetTweetsSearchStreamRequestV2) -> TwitterAPISessionStreamTask {
        return stream.searchStream(request)
    }

    // MARK: - TimelineAPIv2

    public func getUserTweets(_ request: GetUsersTweetsRequestV2) -> TwitterAPISessionJSONTask {
        return timeline.getUserTweets(request)
    }
    public func getUserMensions(_ request: GetUsersMentionsRequestV2) -> TwitterAPISessionJSONTask {
        return timeline.getUserMensions(request)
    }
    public func getUserReverseChronological(_ request: GetUsersTimelinesReverseChronologicalRequestV2) -> TwitterAPISessionJSONTask {
        return timeline.getUserReverseChronological(request)
    }

    // MARK: - TweetAPIv2

    public func getTweets(_ request: GetTweetsRequestV2) -> TwitterAPISessionJSONTask {
        return tweet.getTweets(request)
    }
    public func getTweet(_ request: GetTweetRequestV2) -> TwitterAPISessionJSONTask {
        return tweet.getTweet(request)
    }
    public func getQuoteTweets(_ request: GetTweetsQuoteTweetsRequestV2) -> TwitterAPISessionJSONTask {
        return tweet.getQuoteTweets(request)
    }
    public func deleteTweet(_ request: DeleteTweetRequestV2) -> TwitterAPISessionJSONTask {
        return tweet.deleteTweet(request)
    }
    public func postTweet(_ request: PostTweetsRequestV2) -> TwitterAPISessionJSONTask {
        return tweet.postTweet(request)
    }
    public func hideReply(_ request: PutTweetsHiddenRequestV2) -> TwitterAPISessionJSONTask {
        return tweet.hideReply(request)
    }

    // MARK: - TweetCountAPIv2

    public func getTweetCountRecent(_ request: GetTweetsCountsRecentRequestV2) -> TwitterAPISessionJSONTask {
        return tweetCount.getTweetCountRecent(request)
    }
    public func getTweetCountAll(_ request: GetTweetsCountsAllRequestV2) -> TwitterAPISessionJSONTask {
        return tweetCount.getTweetCountAll(request)
    }

    // MARK: - UserAPIv2

    public func getUser(_ request: GetUserRequestV2) -> TwitterAPISessionJSONTask {
        return user.getUser(request)
    }
    public func getUsers(_ request: GetUsersRequestV2) -> TwitterAPISessionJSONTask {
        return user.getUsers(request)
    }
    public func getUserByUsername(_ request: GetUsersByUsernameRequestV2) -> TwitterAPISessionJSONTask {
        return user.getUserByUsername(request)
    }
    public func getUsersByUsernames(_ request: GetUsersByRequestV2) -> TwitterAPISessionJSONTask {
        return user.getUsersByUsernames(request)
    }
    public func getMe(_ request: GetUsersMeRequestV2) -> TwitterAPISessionJSONTask {
        return user.getMe(request)
    }

    // MARK: - DirectMessageAPIv2

    public func getDmEvents(_ request: GetDmEventsRequestV2) -> TwitterAPISessionJSONTask {
        return dm.getDmEvents(request)
    }
    public func getDmEventsWithParticipantId(_ request: GetDmConversationsWithParticipantIdDmEventsRequestV2) -> TwitterAPISessionJSONTask {
        return dm.getDmEventsWithParticipantId(request)
    }
    public func getDmEventsByConversationsId(_ request: GetDmConversationsIdDmEventsRequestV2) -> TwitterAPISessionJSONTask {
        return dm.getDmEventsByConversationsId(request)
    }
    public func postDmConversationById(_ request: PostDmConversationByIdRequestV2) -> TwitterAPISessionJSONTask {
        return dm.postDmConversationById(request)
    }
    public func postDmConversationWithUser(_ request: PostDmConversationWithUserRequestV2) -> TwitterAPISessionJSONTask {
        return dm.postDmConversationWithUser(request)
    }
    public func postDmConversation(_ request: PostDmConversationRequestV2) -> TwitterAPISessionJSONTask {
        return dm.postDmConversation(request)
    }
}
