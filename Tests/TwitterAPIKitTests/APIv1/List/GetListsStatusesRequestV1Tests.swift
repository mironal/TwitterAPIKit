import TwitterAPIKit
import XCTest

class GetListsStatusesRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetListsStatusesRequestV1(
            list: .listID("lid"),
            count: 15,
            sinceID: "_s_",
            maxID: "_m_",
            includeEntities: true,
            includeRTs: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/lists/statuses.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "list_id": "lid",
                "count": 15,
                "since_id": "_s_",
                "max_id": "_m_",
                "include_entities": true,
                "include_rts": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetListsStatusesRequestV1(
            list: .listID("lid")
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "list_id": "lid"
            ]
        )
    }
}
