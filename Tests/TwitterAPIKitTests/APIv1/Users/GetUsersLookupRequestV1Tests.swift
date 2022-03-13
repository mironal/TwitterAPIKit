import TwitterAPIKit
import XCTest

class GetUsersLookupRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersLookupRequestV1(
            users: .userIDs(["uid1", "uid2"]),
            tweetMode: true,
            includeEntities: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/users/lookup.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_id": "uid1,uid2",
                "tweet_mode": true,
                "include_entities": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetUsersLookupRequestV1(
            users: .screenNames(["s1", "s2"])
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "screen_name": "s1,s2"
            ]
        )
    }
}
