import TwitterAPIKit
import XCTest

class GetUsersFollowersRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersFollowersRequestV2(
            id: "_id_",
            expansions: [.pinnedTweetID],
            maxResults: 10,
            paginationToken: "token",
            tweetFields: [.conversationID],
            userFields: [.username]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_id_/followers")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "pinned_tweet_id",
                "max_results": 10,
                "pagination_token": "token",
                "tweet.fields": "conversation_id",
                "user.fields": "username",
            ])
    }

    func testDefaultArg() throws {
        let req = GetUsersFollowersRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(req.parameters, [:])
    }
}
