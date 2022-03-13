import TwitterAPIKit
import XCTest

class GetFriendsListRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetFriendsListRequestV1(
            user: .userID("uid"),
            count: 1,
            cursor: "_c_",
            skipStatus: true,
            includeUserEntities: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/friends/list.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_id": "uid",
                "count": 1,
                "cursor": "_c_",
                "skip_status": true,
                "include_user_entities": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetFriendsListRequestV1(
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
