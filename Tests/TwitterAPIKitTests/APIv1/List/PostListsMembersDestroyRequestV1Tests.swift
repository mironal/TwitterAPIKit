import TwitterAPIKit
import XCTest

class PostListsMembersDestroyRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostListsMembersDestroyRequestV1(
            list: .listID("lid"),
            user: .userID("uid")
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/members/destroy.json")
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
        let req = PostListsMembersDestroyRequestV1(
            list: .slug(slug: "sl", owner: .screenName("sc")),
            user: .screenName("name")
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "slug": "sl",
                "owner_screen_name": "sc",
                "screen_name": "name",
            ]
        )
    }
}
