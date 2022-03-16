import TwitterAPIKit
import XCTest

class PostCollectionsEntriesCurateRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostCollectionsEntriesCurateRequestV1(
            id: "_i_",
            changes: [
                .add(tweetID: "add_id"),
                .remove(tweetID: "remove_id"),
            ]
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/collections/entries/curate.json")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "id": "_i_",
                "changes": [
                    ["op": "add", "tweet_id": "add_id"],
                    ["op": "remove", "tweet_id": "remove_id"],
                ],
            ]
        )
    }
}
