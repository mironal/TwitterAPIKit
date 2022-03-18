import TwitterAPIKit
import XCTest

class GetTweetsQuoteTweetsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetTweetsQuoteTweetsRequestV2(
            id: "_i_",
            expansions: [.attachmentsMediaKeys],
            maxResults: 10,
            mediaFields: [.height],
            paginationToken: "_p_",
            placeFields: [.country],
            pollFields: [.options],
            tweetFields: [.authorID],
            userFields: [.entities]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/tweets/_i_/quote_tweets")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "attachments.media_keys",
                "max_results": 10,
                "media.fields": "height",
                "pagination_token": "_p_",
                "place.fields": "country",
                "poll.fields": "options",
                "tweet.fields": "author_id",
                "user.fields": "entities",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetTweetsQuoteTweetsRequestV2(
            id: "i"
        )

        XCTAssertEqual(req.path, "/2/tweets/i/quote_tweets")
        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
