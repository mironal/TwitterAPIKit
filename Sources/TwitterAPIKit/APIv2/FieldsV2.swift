import Foundation

// https://developer.twitter.com/en/docs/twitter-api/fields

/// tweet.fields
public enum TwitterTweetFieldsV2: TwitterAPIv2RequestParameter, Hashable {

    case attachments
    case authorID
    case contextAnnotations
    case conversationID
    case createdAt
    case entities
    case geo
    case id
    case inReplyToUserID
    case lang
    case nonPublicMetrics
    case publicMetrics
    case organicMetrics
    case promotedMetrics
    case possiblySensitive
    case referencedTweets
    case replySettings
    case source
    case text
    case withheld
    case other(String)

    public var stringValue: String {

        switch self {
        case .attachments:
            return "attachments"
        case .authorID:
            return "author_id"
        case .contextAnnotations:
            return "context_annotations"
        case .conversationID:
            return "conversation_id"
        case .createdAt:
            return "created_at"
        case .entities:
            return "entities"
        case .geo:
            return "geo"
        case .id:
            return "id"
        case .inReplyToUserID:
            return "in_reply_to_user_id"
        case .lang:
            return "lang"
        case .nonPublicMetrics:
            return "non_public_metrics"
        case .publicMetrics:
            return "public_metrics"
        case .organicMetrics:
            return "organic_metrics"
        case .promotedMetrics:
            return "promoted_metrics"
        case .possiblySensitive:
            return "possibly_sensitive"
        case .referencedTweets:
            return "referenced_tweets"
        case .replySettings:
            return "reply_settings"
        case .source:
            return "source"
        case .text:
            return "text"
        case .withheld:
            return "withheld"
        case .other(let other):
            return other
        }
    }

    public static let all: Set<Self> = [
        .attachments,
        .authorID,
        .contextAnnotations,
        .conversationID,
        .createdAt,
        .entities,
        .geo,
        .id,
        .inReplyToUserID,
        .lang,
        .nonPublicMetrics,
        .publicMetrics,
        .organicMetrics,
        .promotedMetrics,
        .possiblySensitive,
        .referencedTweets,
        .replySettings,
        .source,
        .text,
        .withheld,
    ]
}

extension Set where Element == TwitterTweetFieldsV2 {
    func bind(param: inout [String: Any]) {
        param["tweet.fields"] = commaSeparatedString
    }
}

/// user.fields
public enum TwitterUserFieldsV2: TwitterAPIv2RequestParameter, Hashable {
    case createdAt
    case description
    case entities
    case id
    case location
    case name
    case pinnedTweetID
    case profileImageUrl
    case protected
    case publicMetrics
    case url
    case username
    case verified
    case withheld
    case other(String)

    public var stringValue: String {
        switch self {
        case .createdAt:
            return "created_at"
        case .description:
            return "description"
        case .entities:
            return "entities"
        case .id:
            return "id"
        case .location:
            return "location"
        case .name:
            return "name"
        case .pinnedTweetID:
            return "pinned_tweet_id"
        case .profileImageUrl:
            return "profile_image_url"
        case .protected:
            return "protected"
        case .publicMetrics:
            return "public_metrics"
        case .url:
            return "url"
        case .username:
            return "username"
        case .verified:
            return "verified"
        case .withheld:
            return "withheld"
        case .other(let other):
            return other
        }
    }

    public static let all: Set<Self> = [
        .createdAt,
        .description,
        .entities,
        .id,
        .location,
        .name,
        .pinnedTweetID,
        .profileImageUrl,
        .protected,
        .publicMetrics,
        .url,
        .username,
        .verified,
        .withheld,
    ]
}

extension Set where Element == TwitterUserFieldsV2 {
    func bind(param: inout [String: Any]) {
        param["user.fields"] = commaSeparatedString
    }
}

/// place.fields
public enum TwitterPlaceFieldsV2: TwitterAPIv2RequestParameter, Hashable {

    case containedWithin
    case country
    case countryCode
    case fullName
    case geo
    case id
    case name
    case placeType
    case other(String)

    public var stringValue: String {
        switch self {
        case .containedWithin:
            return "contained_within"
        case .country:
            return "country"
        case .countryCode:
            return "country_code"
        case .fullName:
            return "full_name"
        case .geo:
            return "geo"
        case .id:
            return "id"
        case .name:
            return "name"
        case .placeType:
            return "place_type"
        case .other(let other):
            return other
        }
    }

    public static let all: Set<Self> = [
        .containedWithin,
        .country,
        .countryCode,
        .fullName,
        .geo,
        .id,
        .name,
        .placeType,
    ]
}

extension Set where Element == TwitterPlaceFieldsV2 {
    func bind(param: inout [String: Any]) {
        param["place.fields"] = commaSeparatedString
    }
}

/// poll.fields
public enum TwitterPollFieldsV2: TwitterAPIv2RequestParameter, Hashable {
    case durationMinutes
    case endDatetime
    case id
    case options
    case votingStatus
    case other(String)

    public var stringValue: String {
        switch self {
        case .durationMinutes:
            return "duration_minutes"
        case .endDatetime:
            return "end_datetime"
        case .id:
            return "id"
        case .options:
            return "options"
        case .votingStatus:
            return "voting_status"
        case .other(let other):
            return other
        }
    }

    public static let all: Set<Self> = [
        .durationMinutes,
        .endDatetime,
        .id,
        .options,
        .votingStatus,
    ]
}

extension Set where Element == TwitterPollFieldsV2 {
    func bind(param: inout [String: Any]) {
        param["poll.fields"] = commaSeparatedString
    }
}

/// media.fields
public enum TwitterMediaFieldsV2: TwitterAPIv2RequestParameter, Hashable {
    case durationMs
    case height
    case mediaKey
    case previewImageUrl
    case type
    case url
    case width
    case publicMetrics
    case nonPublicMetrics
    case organicMetrics
    case promotedMetrics
    case altText
    case variants
    case other(String)

    public var stringValue: String {
        switch self {
        case .durationMs: return "duration_ms"
        case .height: return "height"
        case .mediaKey: return "media_key"
        case .previewImageUrl: return "preview_image_url"
        case .type: return "type"
        case .url: return "url"
        case .width: return "width"
        case .publicMetrics: return "public_metrics"
        case .nonPublicMetrics: return "non_public_metrics"
        case .organicMetrics: return "organic_metrics"
        case .promotedMetrics: return "promoted_metrics"
        case .altText: return "alt_text"
        case .variants: return "variants"
        case .other(let string): return string
        }
    }

    public static let all: Set<Self> = [
        .durationMs,
        .height,
        .mediaKey,
        .previewImageUrl,
        .type,
        .url,
        .width,
        .publicMetrics,
        .nonPublicMetrics,
        .organicMetrics,
        .promotedMetrics,
        .altText,
        .variants,
    ]
}

extension Set where Element == TwitterMediaFieldsV2 {
    func bind(param: inout [String: Any]) {
        param["media.fields"] = commaSeparatedString
    }
}

/// list.fields
public enum TwitterListFieldsV2: TwitterAPIv2RequestParameter, Hashable {

    case createdAt
    case followerCount
    case memberCount
    case `private`
    case description
    case id
    case name
    case ownerID
    case other(String)

    public var stringValue: String {
        switch self {
        case .createdAt: return "created_at"
        case .followerCount: return "follower_count"
        case .memberCount: return "member_count"
        case .private: return "private"
        case .description: return "description"
        case .id: return "id"
        case .name: return "name"
        case .ownerID: return "owner_id"
        case .other(let string): return string
        }
    }

    public static let all: Set<Self> = [
        .createdAt,
        .followerCount,
        .memberCount,
        .private,
        .description,
        .id,
        .name,
        .ownerID,
    ]
}

extension Set where Element == TwitterListFieldsV2 {
    func bind(param: inout [String: Any]) {
        param["list.fields"] = commaSeparatedString
    }
}

/// space.fields
public enum TwitterSpaceFieldsV2: TwitterAPIv2RequestParameter, Hashable {

    case id
    case state
    case hostIDs
    case createdAt
    case creatorID
    case lang
    case invitedUserIDs
    case participantCount
    case speakerIDs
    case startedAt
    case endedAt
    case subscriberCount
    case topicIDs
    case title
    case updatedAt
    case scheduledStart
    case isTicketed
    case other(String)

    public var stringValue: String {
        switch self {
        case .id: return "id"
        case .state: return "state"
        case .hostIDs: return "host_ids"
        case .createdAt: return "created_at"
        case .creatorID: return "creator_id"
        case .lang: return "lang"
        case .invitedUserIDs: return "invited_user_ids"
        case .participantCount: return "participant_count"
        case .speakerIDs: return "speaker_ids"
        case .startedAt: return "started_at"
        case .endedAt: return "ended_at"
        case .subscriberCount: return "subscriber_count"
        case .topicIDs: return "topic_ids"
        case .title: return "title"
        case .updatedAt: return "updated_at"
        case .scheduledStart: return "scheduled_start"
        case .isTicketed: return "is_ticketed"
        case .other(let string): return string
        }
    }

    public static let all: Set<Self> = [
        .id,
        .state,
        .hostIDs,
        .createdAt,
        .creatorID,
        .lang,
        .invitedUserIDs,
        .participantCount,
        .speakerIDs,
        .startedAt,
        .endedAt,
        .subscriberCount,
        .topicIDs,
        .title,
        .updatedAt,
        .scheduledStart,
        .isTicketed,
    ]
}

extension Set where Element == TwitterSpaceFieldsV2 {
    func bind(param: inout [String: Any]) {
        param["space.fields"] = commaSeparatedString
    }
}

/// topic.fields
public enum TwitterTopicFieldsV2: TwitterAPIv2RequestParameter, Hashable {

    case id
    case name
    case description
    case other(String)

    public var stringValue: String {
        switch self {
        case .id: return "id"
        case .name: return "name"
        case .description: return "description"
        case .other(let string): return string
        }
    }

    public static let all: Set<Self> = [
        .id,
        .name,
        .description,
    ]
}

extension Set where Element == TwitterTopicFieldsV2 {
    func bind(param: inout [String: Any]) {
        param["topic.fields"] = commaSeparatedString
    }
}

/// A comma separated list of DmEvent fields to display.
/// dm_event.fields
public enum TwitterDmEventFieldsV2: TwitterAPIv2RequestParameter, Hashable {
    case attachments
    case createdAt
    case dmConversationID
    case eventType
    case id
    case participantIDs
    case referencedTweets
    case senderID
    case text
    case other(String)

    public var stringValue: String {
        switch self {
        case .attachments: return "attachments"
        case .createdAt: return "created_at"
        case .dmConversationID: return "dm_conversation_id"
        case .eventType: return "event_type"
        case .id: return "id"
        case .participantIDs: return "participant_ids"
        case .referencedTweets: return "referenced_tweets"
        case .senderID: return "sender_id"
        case .text: return "text"
        case .other(let string): return string
        }
    }

    public static let all: Set<Self> = [
        .attachments,
        .createdAt,
        .dmConversationID,
        .eventType,
        .id,
        .participantIDs,
        .referencedTweets,
        .senderID,
        .text,
    ]
}

extension Set where Element == TwitterDmEventFieldsV2 {
    func bind(param: inout [String: Any]) {
        param["dm_event.fields"] = commaSeparatedString
    }
}

/// A comma separated list of DmConversation fields to display.
/// dm_conversation.fields
public enum TwitterDmConversationFieldsV2: TwitterAPIv2RequestParameter, Hashable {
    case id
    case other(String)

    public var stringValue: String {
        switch self {
        case .id: return "id"
        case .other(let string): return string
        }
    }

    public static let all: Set<Self> = [
        .id
    ]
}

extension Set where Element == TwitterDmConversationFieldsV2 {
    func bind(param: inout [String: Any]) {
        param["dm_conversation.fields"] = commaSeparatedString
    }
}
