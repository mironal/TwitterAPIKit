import TwitterAPIKit
import XCTest

class PostListsMembersCreateAllRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostListsMembersCreateAllRequestV1(
            list: .listID("lid"),
            users: .userIDs(["uid1", "uid2"])
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/members/create_all.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "list_id": "lid",
                "user_id": "uid1,uid2",
            ]
        )
    }
}
