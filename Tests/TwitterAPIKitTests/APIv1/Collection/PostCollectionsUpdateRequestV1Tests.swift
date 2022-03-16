import TwitterAPIKit
import XCTest

class PostCollectionsUpdateRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostCollectionsUpdateRequestV1(
            id: "_i_",
            url: "_u_",
            name: "_n_",
            description: "_d_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/collections/update.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "id": "_i_",
                "url": "_u_",
                "name": "_n_",
                "description": "_d_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostCollectionsUpdateRequestV1(
            id: "i"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "id": "i"
            ]
        )
    }
}
