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
        }
    }
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
        }
    }
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
        }
    }
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
        }
    }
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
    case altTex
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
        case .altTex: return "alt_tex"
        case .other(let string): return string
        }
    }
}

extension Set where Element == TwitterMediaFieldsV2 {
    func bind(param: inout [String: Any]) {
        param["media.fields"] = commaSeparatedString
    }
}
