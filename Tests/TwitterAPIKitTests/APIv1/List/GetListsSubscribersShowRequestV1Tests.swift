import TwitterAPIKit
import XCTest

class GetListsSubscribersShowRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetListsSubscribersShowRequestV1(
            list: .listID("lid"),
            user: .userID("uid"),
            includeEntities: true,
            skipStatus: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/subscribers/show.json")
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

    func testDefaultArg() throws {
        let req = GetListsSubscribersShowRequestV1(
            list: .slug(slug: "sl", owner: .screenName("sn")),
            user: .userID("uid")
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "slug": "sl",
                "owner_screen_name": "sn",
                "user_id": "uid",
            ]
        )
    }
}
