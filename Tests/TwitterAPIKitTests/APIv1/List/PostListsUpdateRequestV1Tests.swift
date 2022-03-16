import TwitterAPIKit
import XCTest

class PostListsUpdateRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostListsUpdateRequestV1(
            list: .listID("lid"),
            name: "_n_",
            mode: .public,
            description: "_d_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/update.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "list_id": "lid",
                "name": "_n_",
                "mode": "public",
                "description": "_d_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostListsUpdateRequestV1(
            list: .slug(slug: "sl", owner: .screenName("name"))
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "slug": "sl",
                "owner_screen_name": "name",
            ]
        )
    }
}
