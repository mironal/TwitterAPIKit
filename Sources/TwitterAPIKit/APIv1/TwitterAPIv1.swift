public typealias TwitterAPIv1 =
    TwitterAPIResourceV1
    // sorted
    & AccountAPIv1
    & ApplicationAPIv1
    & AuthAPIv1
    & BlockAndMuteAPIv1
    & CollectionAPIv1
    & DirectMessageAPIv1
    & FavoriteAPIv1
    & FriendshipsAPIV1
    & GeoAPIv1
    & HelpAPIv1
    & ListAPIv1
    & MediaAPIv1
    & RetweetAPIV1
    & SearchAPIv1
    & TimelineAPIv1
    & TrendAPIv1
    & TweetAPIv1
    & UserAPIv1

public protocol TwitterAPIResourceV1 {
    var account: AccountAPIv1 { get }
    var application: ApplicationAPIv1 { get }
    var auth: AuthAPIv1 { get }
    var blockAndMute: BlockAndMuteAPIv1 { get }
    var collection: CollectionAPIv1 { get }
    var directMessage: DirectMessageAPIv1 { get }
    var favorite: FavoriteAPIv1 { get }
    var friendships: FriendshipsAPIV1 { get }
    var geo: GeoAPIv1 { get }
    var help: HelpAPIv1 { get }
    var list: ListAPIv1 { get }
    var media: MediaAPIv1 { get }
    var retweet: RetweetAPIV1 { get }
    var search: SearchAPIv1 { get }
    var timeline: TimelineAPIv1 { get }
    var trend: TrendAPIv1 { get }
    var tweet: TweetAPIv1 { get }
    var user: UserAPIv1 { get }

}

extension TwitterAPIKit.TwitterAPIImplV1: TwitterAPIResourceV1 {
    var account: AccountAPIv1 { return self }
    var application: ApplicationAPIv1 { return self }
    var auth: AuthAPIv1 { return self }
    var blockAndMute: BlockAndMuteAPIv1 { return self }
    var collection: CollectionAPIv1 { return self }
    var directMessage: DirectMessageAPIv1 { return self }
    var favorite: FavoriteAPIv1 { return self }
    var friendships: FriendshipsAPIV1 { return self }
    var geo: GeoAPIv1 { return self }
    var help: HelpAPIv1 { return self }
    var list: ListAPIv1 { return self }
    var media: MediaAPIv1 { return self }
    var retweet: RetweetAPIV1 { return self }
    var search: SearchAPIv1 { return self }
    var timeline: TimelineAPIv1 { return self }
    var trend: TrendAPIv1 { return self }
    var tweet: TweetAPIv1 { return self }
    var user: UserAPIv1 { return self }
}
