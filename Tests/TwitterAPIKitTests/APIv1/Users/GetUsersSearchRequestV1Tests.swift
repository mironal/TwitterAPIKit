import TwitterAPIKit
import XCTest

class GetUsersSearchRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersSearchRequestV1(
            q: "_q_",
            page: 11,
            count: 100,
            includeEntities: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/users/search.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "q": "_q_",
                "page": 11,
                "count": 100,
                "include_entities": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetUsersSearchRequestV1(
            q: "qq"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "q": "qq"
            ]
        )
    }
}
