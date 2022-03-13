import TwitterAPIKit
import XCTest

class GetUserRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUserRequestV2(
            id: "_id_",
            expansions: [.pinnedTweetID],
            tweetFields: [.entities],
            userFields: [.protected]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_id_")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "pinned_tweet_id",
                "tweet.fields": "entities",
                "user.fields": "protected",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetUserRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
