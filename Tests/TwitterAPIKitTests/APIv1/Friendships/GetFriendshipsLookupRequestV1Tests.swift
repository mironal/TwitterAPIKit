import TwitterAPIKit
import XCTest

class GetFriendshipsLookupRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetFriendshipsLookupRequestV1(
            users: .userIDs(["uid1", "uid2"])
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/friendships/lookup.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_id": "uid1,uid2"
            ]
        )
    }

    func testScreenName() throws {
        let req = GetFriendshipsLookupRequestV1(
            users: .screenNames(["s1", "s2"])
        )

        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "screen_name": "s1,s2"
            ]
        )
    }
}
