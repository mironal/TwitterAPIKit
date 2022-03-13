import TwitterAPIKit
import XCTest

class GetUsersByRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersByRequestV2(
            usernames: ["a", "b"],
            expansions: [.pinnedTweetID],
            tweetFields: [.geo],
            userFields: [.url]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/by")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "usernames": "a,b",
                "expansions": "pinned_tweet_id",
                "tweet.fields": "geo",
                "user.fields": "url",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetUsersByRequestV2(
            usernames: ["a", "b"]
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "usernames": "a,b"
            ]
        )
    }
}
