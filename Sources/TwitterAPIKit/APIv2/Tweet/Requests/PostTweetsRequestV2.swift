import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/post-tweets
open class PostTweetsRequestV2: TwitterAPIRequest {

    public struct Geo {
        public let placeID: String

        func bind(param: inout [String: Any]) {
            var p = [String: Any]()

            p["place_id"] = placeID

            param["geo"] = p
        }
    }

    public struct Media {
        public let mediaIDs: [String]
        public let taggedUserIDs: [String]?

        func bind(param: inout [String: Any]) {
            var p = [String: Any]()

            p["media_ids"] = mediaIDs.joined(separator: ",")
            taggedUserIDs.map { $0.joined(separator: ",") }.map { p["tagged_user_ids"] = $0 }

            param["media"] = p
        }
    }

    public struct Poll {
        public let durationMinutes: Int
        public let options: [String]

        func bind(param: inout [String: Any]) {
            var p = [String: Any]()

            p["duration_minutes"] = durationMinutes
            p["options"] = options.joined(separator: ",")

            param["poll"] = p
        }
    }

    public struct Reply {
        public let excludeReplyUserIDs: [String]?
        public let inReplyToTweetID: String

        func bind(param: inout [String: Any]) {
            var p = [String: Any]()

            excludeReplyUserIDs.map { $0.joined(separator: ",") }.map { p["exclude_reply_user_ids"] = $0 }
            p["in_reply_to_tweet_id"] = inReplyToTweetID

            param["reply"] = p
        }
    }

    public enum ReplySettings: String {
        case mentionedUsers
        case following
        case everyone

        func bind(param: inout [String: Any]) {
            param["reply_settings"] = rawValue
        }
    }

    public let directMessageDeepLink: String?
    public let forSuperFollowersOnly: Bool?
    public let geo: Geo?
    public let media: Media?
    public let poll: Poll?
    public let quoteTweetID: String?
    public let reply: Reply?
    public let replySettings: ReplySettings?
    public let text: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/tweets"
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        directMessageDeepLink.map { p["direct_message_deep_link"] = $0 }
        forSuperFollowersOnly.map { p["for_super_followers_only"] = $0 }
        geo?.bind(param: &p)
        media?.bind(param: &p)
        poll?.bind(param: &p)
        quoteTweetID.map { p["quote_tweet_id"] = $0 }
        reply?.bind(param: &p)
        replySettings?.bind(param: &p)
        text.map { p["text"] = $0 }
        return p
    }

    public init(
        directMessageDeepLink: String? = .none,
        forSuperFollowersOnly: Bool? = .none,
        geo: PostTweetsRequestV2.Geo? = .none,
        media: PostTweetsRequestV2.Media? = .none,
        poll: PostTweetsRequestV2.Poll? = .none,
        quoteTweetID: String? = .none,
        reply: PostTweetsRequestV2.Reply? = .none,
        replySettings: PostTweetsRequestV2.ReplySettings? = .none,
        text: String? = .none
    ) {
        self.directMessageDeepLink = directMessageDeepLink
        self.forSuperFollowersOnly = forSuperFollowersOnly
        self.geo = geo
        self.media = media
        self.poll = poll
        self.quoteTweetID = quoteTweetID
        self.reply = reply
        self.replySettings = replySettings
        self.text = text
    }
}
