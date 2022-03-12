import TwitterAPIKit
import XCTest

class GetFriendsIDsRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetFriendsIDsRequestV1(
            user: .userID("uid"),
            count: 11,
            cursor: "_c_",
            stringifyIDs: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/friends/ids.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_id": "uid",
                "count": 11,
                "cursor": "_c_",
                "stringify_ids": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetFriendsIDsRequestV1(
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
