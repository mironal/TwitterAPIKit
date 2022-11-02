import Foundation

// https://developer.twitter.com/en/docs/api-reference-index

open class TwitterAPIv2 {
    public let blockAndMute: BlockAndMuteAPIv2
    public let bookmarks: BookmarksAPIv2
    public let compliance: ComplianceAPIv2
    public let friendships: FriendshipsAPIv2
    public let like: LikeAPIv2
    public let list: ListAPIv2
    public let retweet: RetweetAPIv2
    public let search: SearchAPIv2
    public let spaces: SpacesAPIv2
    public let stream: StreamAPIv2
    public let timeline: TimelineAPIv2
    public let tweet: TweetAPIv2
    public let tweetCount: TweetCountAPIv2
    public let user: UserAPIv2
    public let dm: DirectMessageAPIv2

    public init(session: TwitterAPISession) {
        blockAndMute = .init(session: session)
        bookmarks = .init(session: session)
        compliance = .init(session: session)
        friendships = .init(session: session)
        like = .init(session: session)
        list = .init(session: session)
        retweet = .init(session: session)
        search = .init(session: session)
        spaces = .init(session: session)
        stream = .init(session: session)
        timeline = .init(session: session)
        tweet = .init(session: session)
        tweetCount = .init(session: session)
        user = .init(session: session)
        dm = .init(session: session)
    }
}

public protocol TwitterAPIv2RequestParameter {
    var stringValue: String { get }
}

extension Collection where Element: TwitterAPIv2RequestParameter {
    var commaSeparatedString: String {
        return map { $0.stringValue }.sorted().joined(separator: ",")
    }
}
