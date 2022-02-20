import Foundation

// https://developer.twitter.com/en/docs/api-reference-index

public typealias TwitterAPIv2 =
    TwitterAPIResourceV2
    & BlockAndMuteAPIv2
    & LikeAPIv2
    & RetweetAPIv2
    & TimelineAPIv2
    & TweetAPIv2
    & TweetCountAPIv2
    & UserAPIv2

public protocol TwitterAPIResourceV2 {
    var blockAndMute: BlockAndMuteAPIv2 { get }
    var like: LikeAPIv2 { get }
    var retweet: RetweetAPIv2 { get }
    var timeline: TimelineAPIv2 { get }
    var tweet: TweetAPIv2 { get }
    var tweetCount: TweetCountAPIv2 { get }
    var user: UserAPIv2 { get }
}

extension TwitterAPIKit.TwitterAPIImplV2: TwitterAPIResourceV2 {
    var blockAndMute: BlockAndMuteAPIv2 { return self }
    var like: LikeAPIv2 { return self }
    var retweet: RetweetAPIv2 { return self }
    var timeline: TimelineAPIv2 { return self }
    var tweet: TweetAPIv2 { return self }
    var tweetCount: TweetCountAPIv2 { return self }
    var user: UserAPIv2 { return self }
}

public protocol TwitterAPIv2RequestParameter {
    var stringValue: String { get }
}

extension Set where Element: TwitterAPIv2RequestParameter {
    var commaSeparatedString: String {
        return map { $0.stringValue }.sorted().joined(separator: ",")
    }
}
