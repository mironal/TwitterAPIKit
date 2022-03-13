import TwitterAPIKit
import XCTest

class GetUsersMeRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersMeRequestV2(
            expansions: [.pinnedTweetID],
            tweetFields: [.geo],
            userFields: [.id]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/me")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "pinned_tweet_id",
                "tweet.fields": "geo",
                "user.fields": "id",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetUsersMeRequestV2()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
