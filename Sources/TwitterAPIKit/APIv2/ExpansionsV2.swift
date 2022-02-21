import Foundation

// https://developer.twitter.com/en/docs/twitter-api/expansions

protocol TwitterExpansionsParameterV2: TwitterAPIv2RequestParameter {}

extension Set where Element: TwitterExpansionsParameterV2 {
    func bind(param: inout [String: Any]) {
        param["expansions"] = commaSeparatedString
    }
}

public enum TwitterTweetExpansionsV2: TwitterExpansionsParameterV2, Hashable {

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

public enum TwitterUserExpansionsV2: TwitterExpansionsParameterV2, Hashable {
    case pinnedTweetID
    case other(String)

    public var stringValue: String {
        switch self {
        case .pinnedTweetID: return "pinned_tweet_id"
        case .other(let string): return string
        }
    }
}

public enum TwitterListExpansionsV2: TwitterExpansionsParameterV2, Hashable {
    case ownerID
    case other(String)

    public var stringValue: String {
        switch self {
        case .ownerID: return "owner_id"
        case .other(let string): return string
        }
    }
}

public enum TwitterSpaceExpansionsV2: TwitterExpansionsParameterV2, Hashable {

    case invitedUserIDs
    case speakerIDs
    case creatorID
    case hostIDs
    case other(String)

    public var stringValue: String {
        switch self {
        case .invitedUserIDs: return "invited_user_ids"
        case .speakerIDs: return "speaker_ids"
        case .creatorID: return "creator_id"
        case .hostIDs: return "host_ids"
        case .other(let string): return string
        }
    }
}
