import TwitterAPIKit
import XCTest

class GetUsersFollowingRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersFollowingRequestV2(
            id: "_id_",
            expansions: [.pinnedTweetID],
            maxResults: 20,
            paginationToken: "t",
            tweetFields: [.text],
            userFields: [.name]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_id_/following")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "pinned_tweet_id",
                "max_results": 20,
                "pagination_token": "t",
                "tweet.fields": "text",
                "user.fields": "name",
            ])
    }

    func testDefaultArg() throws {
        let req = GetUsersFollowingRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(req.parameters, [:])
    }
}
