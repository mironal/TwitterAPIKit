import TwitterAPIKit
import XCTest

class PostListsMembersCreateRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostListsMembersCreateRequestV1(
            list: .listID("lid"),
            user: .userID("uid")
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/members/create.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "list_id": "lid",
                "user_id": "uid",
            ]
        )
    }

    func testScreenName() throws {
        let req = PostListsMembersCreateRequestV1(
            list: .slug(slug: "sl", owner: .screenName("osname")),
            user: .screenName("sname")
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "slug": "sl",
                "owner_screen_name": "osname",
                "screen_name": "sname",
            ]
        )
    }
}
