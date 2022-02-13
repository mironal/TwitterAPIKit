import Foundation

// https://developer.twitter.com/en/docs/twitter-api/expansions

public enum TwitterTweetExpansionsV2: TwitterAPIV2RequestParameter, Hashable {

    case attachmentsPollIDs
    case attachmentsMediaKeys
    case authorID
    case entitiesMentionsUsername
    case geoPlaceID
    case inReplyToUserID
    case referencedTweetsID
    case referencedTweetsIDAuthorID
    case other(String)

    public var stringValue: String {
        switch self {
        case .attachmentsPollIDs: return "attachments.poll_ids"
        case .attachmentsMediaKeys: return "attachments.media_keys"
        case .authorID: return "author_id"
        case .entitiesMentionsUsername: return "entities.mentions.username"
        case .geoPlaceID: return "geo.place_id"
        case .inReplyToUserID: return "in_reply_to_user_id"
        case .referencedTweetsID: return "referenced_tweets.id"
        case .referencedTweetsIDAuthorID: return "referenced_tweets.id.author_id"
        case .other(let string): return string
        }
    }
}

extension Set where Element == TwitterTweetExpansionsV2 {
    func bind(param: inout [String: Any]) {
        param["expansions"] = commaSeparatedString
    }
}

public enum TwitterUserExpansionsV2: TwitterAPIV2RequestParameter, Hashable {
    case pinnedTweetID

    public var stringValue: String {
        switch self {
        case .pinnedTweetID: return "pinned_tweet_id"
        }
    }
}

extension Set where Element == TwitterUserExpansionsV2 {
    func bind(param: inout [String: Any]) {
        param["expansions"] = commaSeparatedString
    }
}
