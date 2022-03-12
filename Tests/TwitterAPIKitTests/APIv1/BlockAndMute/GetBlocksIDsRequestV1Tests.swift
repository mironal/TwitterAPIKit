import TwitterAPIKit
import XCTest

class GetBlocksIDsRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetBlocksIDsRequestV1(
            stringifyIDs: true,
            cursor: "_c_"
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/blocks/ids.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "stringify_ids": true,
                "cursor": "_c_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetBlocksIDsRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
