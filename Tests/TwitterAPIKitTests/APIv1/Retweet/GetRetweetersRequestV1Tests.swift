import TwitterAPIKit
import XCTest

class GetRetweetersRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetRetweetersRequestV1(
            id: "_i_",
            count: 100,
            cursor: "_c_",
            stringifyIDs: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/statuses/retweeters/ids.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "id": "_i_",
                "count": 100,
                "cursor": "_c_",
                "stringify_ids": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetRetweetersRequestV1(
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
