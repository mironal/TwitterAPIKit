import TwitterAPIKit
import XCTest

class GetListsMembersShowRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetListsMembersShowRequestV1(
            list: .listID("lid"),
            user: .userID("uid"),
            includeEntities: true,
            skipStatus: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/members/show.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "list_id": "lid",
                "user_id": "uid",
                "include_entities": true,
                "skip_status": true,
            ]
        )
    }

    func testScreenName() throws {
        let req = GetListsMembersShowRequestV1(
            list: .listID("lid"),
            user: .screenName("s")
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "list_id": "lid",
                "screen_name": "s",
            ]
        )
    }

    func testSlugUserID() throws {
        let req = GetListsMembersShowRequestV1(
            list: .slug(slug: "s", owner: .userID("ouid")),
            user: .userID("uid")
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "slug": "s",
                "owner_id": "ouid",
                "user_id": "uid",
            ]
        )
    }

    func testSlugScreenName() throws {
        let req = GetListsMembersShowRequestV1(
            list: .slug(slug: "s", owner: .screenName("os")),
            user: .userID("uid")
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "slug": "s",
                "owner_screen_name": "os",
                "user_id": "uid",
            ]
        )
    }
}
