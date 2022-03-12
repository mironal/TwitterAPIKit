import TwitterAPIKit
import XCTest

class GetTweetsSearchStreamRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetTweetsSearchStreamRequestV2(
            backfillMinutes: 1,
            expansions: [.referencedTweetsIDAuthorID],
            mediaFields: [.height],
            placeFields: [.name],
            pollFields: [.endDatetime],
            tweetFields: [.geo],
            userFields: [.withheld]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/tweets/search/stream")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "backfill_minutes": 1,
                "expansions": "referenced_tweets.id.author_id",
                "media.fields": "height",
                "place.fields": "name",
                "poll.fields": "end_datetime",
                "tweet.fields": "geo",
                "user.fields": "withheld",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetTweetsSearchStreamRequestV2()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
