import TwitterAPIKit
import XCTest

class PostUnFavoriteRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostUnFavoriteRequestV1(
            id: "_i_",
            includeEntities: true
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/favorites/destroy.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "id": "_i_",
                "include_entities": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostUnFavoriteRequestV1(
            id: "_i_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "id": "_i_"
            ]
        )
    }
}
