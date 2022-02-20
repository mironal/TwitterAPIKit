import Foundation

// https://developer.twitter.com/en/docs/api-reference-index

public typealias TwitterAPIv2 =
    TwitterAPIResourceV2
    & LikeAPIv2
    & RetweetAPIv2
    & TimelineAPIv2
    & TweetAPIv2
    & TweetCountAPIv2

public protocol TwitterAPIResourceV2 {
    var like: LikeAPIv2 { get }
    var retweet: RetweetAPIv2 { get }
    var timeline: TimelineAPIv2 { get }
    var tweet: TweetAPIv2 { get }
    var tweetCount: TweetCountAPIv2 { get }
}

extension TwitterAPIKit.TwitterAPIImplV2: TwitterAPIResourceV2 {
    var like: LikeAPIv2 { return self }
    var retweet: RetweetAPIv2 { return self }
    var timeline: TimelineAPIv2 { return self }
    var tweet: TweetAPIv2 { return self }
    var tweetCount: TweetCountAPIv2 { return self }
}

public protocol TwitterAPIV2RequestParameter {
    var stringValue: String { get }
}

extension Set where Element: TwitterAPIV2RequestParameter {
    var commaSeparatedString: String {
        return map { $0.stringValue }.sorted().joined(separator: ",")
    }
}
