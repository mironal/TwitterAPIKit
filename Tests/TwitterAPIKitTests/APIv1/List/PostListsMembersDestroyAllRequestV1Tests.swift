import TwitterAPIKit
import XCTest

class PostListsMembersDestroyAllRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostListsMembersDestroyAllRequestV1(
            list: .listID("lid"),
            users: .userIDs(["uid1", "uid2"])
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/members/destroy_all.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "list_id": "lid",
                "user_id": "uid1,uid2",
            ]
        )
    }

    func testScreenName() throws {
        let req = PostListsMembersDestroyAllRequestV1(
            list: .slug(slug: "sl", owner: .screenName("oname")),
            users: .screenNames(["s1", "s2"])
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "slug": "sl",
                "owner_screen_name": "oname",
                "screen_name": "s1,s2",
            ]
        )
    }
}
