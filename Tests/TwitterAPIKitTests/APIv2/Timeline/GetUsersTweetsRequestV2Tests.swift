import TwitterAPIKit
import XCTest

class GetUsersTweetsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersTweetsRequestV2(
            id: "_i_",
            endTime: Date(timeIntervalSince1970: 10),
            exclude: [.replies, .retweets],
            expansions: [.authorID],
            maxResults: 100,
            mediaFields: [.publicMetrics],
            paginationToken: "_p_",
            placeFields: [.containedWithin],
            pollFields: [.options],
            sinceID: "_s_",
            startTime: Date(timeIntervalSince1970: 1),
            tweetFields: [.entities],
            untilID: "_u_",
            userFields: [.protected]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_i_/tweets")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "end_time": "1970-01-01T00:00:10Z",
                "exclude": "replies,retweets",
                "expansions": "author_id",
                "max_results": 100,
                "media.fields": "public_metrics",
                "pagination_token": "_p_",
                "place.fields": "contained_within",
                "poll.fields": "options",
                "since_id": "_s_",
                "start_time": "1970-01-01T00:00:01Z",
                "tweet.fields": "entities",
                "until_id": "_u_",
                "user.fields": "protected",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetUsersTweetsRequestV2(
            id: "_i_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
