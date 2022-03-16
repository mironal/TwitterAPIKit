import TwitterAPIKit
import XCTest

class GetListsSubscribersRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetListsSubscribersRequestV1(
            list: .listID("lid"),
            count: 17,
            cursor: "_c_",
            includeEntities: true,
            skipStatus: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/subscribers.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "list_id": "lid",
                "count": 17,
                "cursor": "_c_",
                "include_entities": true,
                "skip_status": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetListsSubscribersRequestV1(
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
}
