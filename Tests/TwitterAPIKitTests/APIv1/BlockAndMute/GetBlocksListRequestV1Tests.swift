import TwitterAPIKit
import XCTest

class GetBlocksListRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetBlocksListRequestV1(
            includeEntities: true,
            skipStatus: true,
            cursor: "_c_"
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/blocks/list.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "include_entities": true,
                "skip_status": true,
                "cursor": "_c_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetBlocksListRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
