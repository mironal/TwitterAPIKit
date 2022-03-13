import TwitterAPIKit
import XCTest

class PostListsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostListsRequestV2(
            name: "_name_",
            description: "d",
            private: true
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/lists")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "name": "_name_",
                "description": "d",
                "private": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostListsRequestV2(
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
