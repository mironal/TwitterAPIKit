import TwitterAPIKit
import XCTest

class PostCollectionsEntriesMoveRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostCollectionsEntriesMoveRequestV1(
            id: "_i_",
            tweetID: "_t_",
            above: true,
            relativeTo: "_r_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/collections/entries/move.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "id": "_i_",
                "tweet_id": "_t_",
                "above": true,
                "relative_to": "_r_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostCollectionsEntriesMoveRequestV1(
            id: "_i_",
            tweetID: "_t_",
            relativeTo: "_r_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "id": "_i_",
                "tweet_id": "_t_",
                "relative_to": "_r_",
            ]
        )
    }
}
