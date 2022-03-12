import TwitterAPIKit
import XCTest

class PostBlocksDestroyRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostBlocksDestroyRequestV1(
            user: .userID("uid"),
            includeEntities: true,
            skipStatus: true
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/blocks/destroy.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_id": "uid",
                "include_entities": true,
                "skip_status": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostBlocksDestroyRequestV1(
            user: .screenName("s")
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "screen_name": "s"
            ]
        )
    }
}
