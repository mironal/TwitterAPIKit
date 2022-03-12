import TwitterAPIKit
import XCTest

class GetUsersRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersRequestV2(
            ids: ["a", "b"],
            expansions: [.pinnedTweetID],
            tweetFields: [.createdAt],
            userFields: [.publicMetrics]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "ids": "a,b",
                "expansions": "pinned_tweet_id",
                "tweet.fields": "created_at",
                "user.fields": "public_metrics",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetUsersRequestV2(
            ids: ["a", "b"]
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "ids": "a,b"
            ]
        )
    }
}
