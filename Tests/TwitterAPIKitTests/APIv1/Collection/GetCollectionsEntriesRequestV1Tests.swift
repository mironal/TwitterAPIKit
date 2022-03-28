import TwitterAPIKit
import XCTest

class GetCollectionsEntriesRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetCollectionsEntriesRequestV1(
            id: "_i_",
            count: 12,
            maxPosition: "_m_",
            minPosition: "_m_"
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/collections/entries.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "id": "_i_",
                "count": 12,
                "max_position": "_m_",
                "min_position": "_m_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetCollectionsEntriesRequestV1(
            id: "i"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "id": "i"
            ]
        )
    }
}
