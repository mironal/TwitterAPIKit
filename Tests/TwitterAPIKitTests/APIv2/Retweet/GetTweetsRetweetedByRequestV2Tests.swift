import TwitterAPIKit
import XCTest

class GetTweetsRetweetedByRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetTweetsRetweetedByRequestV2(
            id: "_id_",
            expansions: [.pinnedTweetID],
            maxResults: 11,
            mediaFields: [.height, .nonPublicMetrics],
            paginationToken: "t",
            placeFields: [.id, .placeType, .countryCode],
            pollFields: [.options, .endDatetime],
            tweetFields: [.nonPublicMetrics, .contextAnnotations],
            userFields: [.username, .withheld]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/tweets/_id_/retweeted_by")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "pinned_tweet_id",
                "max_results": 11,
                "media.fields": "height,non_public_metrics",
                "pagination_token": "t",
                "place.fields": "country_code,id,place_type",
                "poll.fields": "end_datetime,options",
                "tweet.fields": "context_annotations,non_public_metrics",
                "user.fields": "username,withheld",
            ])
    }

    func testDefaultArg() throws {
        let req = GetTweetsRetweetedByRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(req.parameters, [:])
    }
}
