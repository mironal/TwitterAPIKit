import TwitterAPIKit
import XCTest

class GetUsersLikedTweetsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersLikedTweetsRequestV2(
            id: "_id_",
            expansions: [.authorID],
            maxResults: 10,
            mediaFields: [.durationMs],
            paginationToken: "p",
            placeFields: [.name],
            pollFields: [.id],
            tweetFields: [.entities],
            userFields: [.username]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_id_/liked_tweets")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "author_id",
                "max_results": 10,
                "media.fields": "duration_ms",
                "pagination_token": "p",
                "place.fields": "name",
                "poll.fields": "id",
                "tweet.fields": "entities",
                "user.fields": "username",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetUsersLikedTweetsRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
