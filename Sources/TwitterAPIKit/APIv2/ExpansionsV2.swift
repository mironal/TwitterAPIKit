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

    public static let all: Set<Self> = [
        .attachmentsPollIDs,
        .attachmentsMediaKeys,
        .authorID,
        .entitiesMentionsUsername,
        .geoPlaceID,
        .inReplyToUserID,
        .referencedTweetsID,
        .referencedTweetsIDAuthorID,
    ]
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

    public static let all: Set<Self> = [
        .pinnedTweetID
    ]
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

    public static let all: Set<Self> = [
        .ownerID
    ]
}

public enum TwitterSpaceExpansionsV2: TwitterExpansionsParameterV2, Hashable {

    case invitedUserIDs
    case speakerIDs
    case creatorID
    case hostIDs
    case topicIDs
    case other(String)

    public var stringValue: String {
        switch self {
        case .invitedUserIDs: return "invited_user_ids"
        case .speakerIDs: return "speaker_ids"
        case .creatorID: return "creator_id"
        case .hostIDs: return "host_ids"
        case .topicIDs: return "topic_ids"
        case .other(let string): return string
        }
    }

    public static let all: Set<Self> = [
        .invitedUserIDs,
        .speakerIDs,
        .creatorID,
        .topicIDs,
        .hostIDs,
    ]
}

/// A comma separated list of fields to expand.
/// expansions
public enum TwitterDmEventExpansionsV2: TwitterExpansionsParameterV2, Hashable {
    case attachmentsMediaKeys
    case participantIDs
    case referencedTweetsID
    case senderID
    case other(String)

    public var stringValue: String {
        switch self {
        case .attachmentsMediaKeys: return "attachments.media_keys"
        case .participantIDs: return "participant_ids"
        case .referencedTweetsID: return "referenced_tweets.id"
        case .senderID: return "sender_id"
        case .other(let string): return string
        }
    }

    public static let all: Set<Self> = [
        .attachmentsMediaKeys,
        .participantIDs,
        .referencedTweetsID,
        .senderID,
    ]
}
