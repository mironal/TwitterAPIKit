import TwitterAPIKit
import XCTest

class GetFavoritesRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetFavoritesRequestV1(
            target: .userID("uid"),
            count: 100,
            sinceID: "_s_",
            maxID: "_m_",
            includeEntities: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/favorites/list.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_id": "uid",
                "count": 100,
                "since_id": "_s_",
                "max_id": "_m_",
                "include_entities": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetFavoritesRequestV1(
            target: .screenName("s")
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "screen_name": "s"
            ]
        )
    }
}
