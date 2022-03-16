import TwitterAPIKit
import XCTest

class GetListsShowRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetListsShowRequestV1(
            list: .listID("lid")
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/show.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "list_id": "lid"
            ]
        )
    }

    func testSlugUserID() throws {
        let req = GetListsShowRequestV1(
            list: .slug(slug: "sl", owner: .userID("uid"))
        )
        AssertEqualAnyDict(
            req.parameters,
            [
                "slug": "sl",
                "owner_id": "uid",
            ]
        )
    }

    func testSlugScreenName() throws {
        let req = GetListsShowRequestV1(
            list: .slug(slug: "sl", owner: .screenName("sname"))
        )
        AssertEqualAnyDict(
            req.parameters,
            [
                "slug": "sl",
                "owner_screen_name": "sname",
            ]
        )
    }
}
