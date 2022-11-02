import TwitterAPIKit
import XCTest

class GetDmEventsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetDmEventsRequestV2(
            maxResults: 10,
            paginationToken: "_p_",
            eventTypes: [],
            dmEventFields: [.referencedTweets],
            expansions: [.referencedTweetsID],
            mediaFields: [.altText],
            userFields: [.username],
            tweetFields: [.lang]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/dm_events")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "max_results": 10,
                "pagination_token": "_p_",
                "event_types": "",
                "dm_event.fields": "referenced_tweets",
                "expansions": "referenced_tweets.id",
                "media.fields": "alt_text",
                "user.fields": "username",
                "tweet.fields": "lang",
            ]
        )
    }
}
