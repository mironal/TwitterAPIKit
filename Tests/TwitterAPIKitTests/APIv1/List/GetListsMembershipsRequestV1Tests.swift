import TwitterAPIKit
import XCTest

class GetListsMembershipsRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetListsMembershipsRequestV1(
            user: .userID("uid"),
            count: 11,
            cursor: "_c_",
            filterToOwnedLists: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/memberships.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_id": "uid",
                "count": 11,
                "cursor": "_c_",
                "filter_to_owned_lists": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetListsMembershipsRequestV1(
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
