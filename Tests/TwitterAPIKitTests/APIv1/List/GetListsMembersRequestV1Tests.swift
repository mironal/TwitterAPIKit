import TwitterAPIKit
import XCTest

class GetListsMembersRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetListsMembersRequestV1(
            list: .listID("lid"),
            count: 10,
            cursor: "_c_",
            includeEntities: true,
            skipStatus: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/members.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "list_id": "lid",
                "count": 10,
                "cursor": "_c_",
                "include_entities": true,
                "skip_status": true,
            ]
        )
    }

    func testSlugUserID() throws {
        let req = GetListsMembersRequestV1(
            list: .slug(slug: "s", owner: .userID("uid"))
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "slug": "s",
                "owner_id": "uid",
            ]
        )
    }

    func testSlugScreenName() throws {
        let req = GetListsMembersRequestV1(
            list: .slug(slug: "s", owner: .screenName("s"))
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "slug": "s",
                "owner_screen_name": "s",
            ]
        )
    }
}
