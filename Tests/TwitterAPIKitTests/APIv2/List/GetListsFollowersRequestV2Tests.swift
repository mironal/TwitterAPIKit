import TwitterAPIKit
import XCTest

class GetListsFollowersRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetListsFollowersRequestV2(
            id: "_id_",
            expansions: [.pinnedTweetID],
            maxResults: 12,
            paginationToken: "t",
            tweetFields: [.entities],
            userFields: [.verified]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/lists/_id_/followers")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "pinned_tweet_id",
                "max_results": 12,
                "pagination_token": "t",
                "tweet.fields": "entities",
                "user.fields": "verified",
            ])
    }

    func testDefaultArg() throws {
        let req = GetListsFollowersRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(req.parameters, [:])
    }
}
