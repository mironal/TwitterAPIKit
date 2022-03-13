import TwitterAPIKit
import XCTest

class GetSpacesTweetsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetSpacesTweetsRequestV2(
            id: "_i_",
            expansions: [.entitiesMentionsUsername],
            mediaFields: [.url],
            placeFields: [.placeType],
            pollFields: [.votingStatus],
            tweetFields: [.contextAnnotations],
            userFields: [.publicMetrics]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/spaces/_i_/tweets")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "entities.mentions.username",
                "media.fields": "url",
                "place.fields": "place_type",
                "poll.fields": "voting_status",
                "tweet.fields": "context_annotations",
                "user.fields": "public_metrics",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetSpacesTweetsRequestV2(
            id: "_i_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
