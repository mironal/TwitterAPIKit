import TwitterAPIKit
import XCTest

class PostTweetsRequestV2Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        let request = PostTweetsRequestV2(
            directMessageDeepLink: "deep_link",
            forSuperFollowersOnly: true,
            geo: .init(placeID: "place"),
            media: .init(
                mediaIDs: ["media_1", "media_2"],
                taggedUserIDs: ["user_1", "user_2"]),
            poll: .init(durationMinutes: 100, options: ["o1", "o2"]),
            quoteTweetID: "quote_id",
            reply: .init(excludeReplyUserIDs: ["r_1", "r_2"], inReplyToTweetID: "t_1"),
            replySettings: .following,
            text: "text"
        )

        XCTAssertEqual(request.path, "/2/tweets")
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.bodyContentType, .json)

        AssertEqualAnyDict(
            request.parameters,
            [
                "direct_message_deep_link": "deep_link",
                "for_super_followers_only": true,
                "geo": ["place_id": "place"],
                "media": ["tagged_user_ids": ["user_1", "user_2"], "media_ids": ["media_1", "media_2"]],
                "poll": ["options": ["o1", "o2"], "duration_minutes": 100],
                "quote_tweet_id": "quote_id",
                "reply": ["in_reply_to_tweet_id": "t_1", "exclude_reply_user_ids": ["r_1", "r_2"]],
                "reply_settings": "following",
                "text": "text",
            ])
    }
}
