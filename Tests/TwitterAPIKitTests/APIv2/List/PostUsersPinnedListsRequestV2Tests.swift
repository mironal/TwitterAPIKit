import TwitterAPIKit
import XCTest

class PostUsersPinnedListsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostUsersPinnedListsRequestV2(
            id: "_id_",
            listID: "_listID_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_id_/pinned_lists")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "list_id": "_listID_"
            ]
        )
    }
}
