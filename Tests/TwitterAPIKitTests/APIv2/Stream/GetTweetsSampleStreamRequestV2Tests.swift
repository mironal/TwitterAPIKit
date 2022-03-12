import TwitterAPIKit
import XCTest

class GetTweetsSampleStreamRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetTweetsSampleStreamRequestV2(
            backfillMinutes: 2,
            expansions: [.entitiesMentionsUsername],
            mediaFields: [.durationMs],
            placeFields: [.countryCode],
            pollFields: [.options],
            tweetFields: [.entities],
            userFields: [.pinnedTweetID]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/tweets/sample/stream")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "backfill_minutes": 2,
                "expansions": "entities.mentions.username",
                "media.fields": "duration_ms",
                "place.fields": "country_code",
                "poll.fields": "options",
                "tweet.fields": "entities",
                "user.fields": "pinned_tweet_id",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetTweetsSampleStreamRequestV2()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
