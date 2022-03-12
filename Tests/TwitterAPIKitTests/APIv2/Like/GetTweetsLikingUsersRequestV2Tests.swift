import TwitterAPIKit
import XCTest

class GetTweetsLikingUsersRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetTweetsLikingUsersRequestV2(
            id: "_id_",
            expansions: [.pinnedTweetID],
            maxResults: 11,
            mediaFields: [.url, .height],
            paginationToken: "p",
            placeFields: [.name],
            pollFields: [.votingStatus],
            tweetFields: [.entities],
            userFields: [.username]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/tweets/_id_/liking_users")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "pinned_tweet_id",
                "max_results": 11,
                "media.fields": "height,url",
                "pagination_token": "p",
                "place.fields": "name",
                "poll.fields": "voting_status",
                "tweet.fields": "entities",
                "user.fields": "username",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetTweetsLikingUsersRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
