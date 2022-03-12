import TwitterAPIKit
import XCTest

class GetTweetsSearchAllRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetTweetsSearchAllRequestV2(
            query: "_q_",
            endTime: Date(timeIntervalSince1970: 2),
            expansions: [.referencedTweetsID],
            maxResults: 13,
            mediaFields: [.nonPublicMetrics],
            nextToken: "_n_",
            placeFields: [.geo],
            pollFields: [.options],
            sinceID: "_s_",
            sortOrder: .relevancy,
            startTime: Date(timeIntervalSince1970: 1),
            tweetFields: [.id],
            untilID: "_u_",
            userFields: [.verified]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/tweets/search/all")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "query": "_q_",
                "end_time": "1970-01-01T00:00:02Z",
                "expansions": "referenced_tweets.id",
                "max_results": 13,
                "media.fields": "non_public_metrics",
                "next_token": "_n_",
                "place.fields": "geo",
                "poll.fields": "options",
                "since_id": "_s_",
                "sort_order": "relevancy",
                "start_time": "1970-01-01T00:00:01Z",
                "tweet.fields": "id",
                "until_id": "_u_",
                "user.fields": "verified",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetTweetsSearchAllRequestV2(
            query: "_q1_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "query": "_q1_"
            ]
        )
    }
}
