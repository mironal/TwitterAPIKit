import TwitterAPIKit
import XCTest

class GetListsMembersRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetListsMembersRequestV2(
            id: "_id_",
            expansions: [.pinnedTweetID],
            maxResults: 100,
            paginationToken: "t",
            tweetFields: [.createdAt],
            userFields: [.protected]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/lists/_id_/members")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "pinned_tweet_id",
                "max_results": 100,
                "pagination_token": "t",
                "tweet.fields": "created_at",
                "user.fields": "protected",
            ])
    }

    func testDefaultArg() throws {
        let req = GetListsMembersRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(req.parameters, [:])
    }
}
