import TwitterAPIKit
import XCTest

class GetSpacesBuyersRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetSpacesBuyersRequestV2(
            id: "_i_",
            expansions: [.pinnedTweetID],
            mediaFields: [.url],
            placeFields: [.geo],
            pollFields: [.options],
            tweetFields: [.entities],
            userFields: [.protected]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/spaces/_i_/buyers")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "pinned_tweet_id",
                "media.fields": "url",
                "place.fields": "geo",
                "poll.fields": "options",
                "tweet.fields": "entities",
                "user.fields": "protected",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetSpacesBuyersRequestV2(
            id: "_i_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
