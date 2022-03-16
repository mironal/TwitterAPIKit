import TwitterAPIKit
import XCTest

class GetListsOwnershipsRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetListsOwnershipsRequestV1(
            user: .userID("uid"),
            count: 21,
            cursor: "_c_"
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/ownerships.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_id": "uid",
                "count": 21,
                "cursor": "_c_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetListsOwnershipsRequestV1(
            user: .screenName("name")
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "screen_name": "name"
            ]
        )
    }
}
