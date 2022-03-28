import TwitterAPIKit
import XCTest

class PostListsCreateRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostListsCreateRequestV1(
            name: "_n_",
            mode: .private,
            description: "_d_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/create.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "name": "_n_",
                "mode": "private",
                "description": "_d_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostListsCreateRequestV1(
            name: "n"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "name": "n"
            ]
        )
    }
}
