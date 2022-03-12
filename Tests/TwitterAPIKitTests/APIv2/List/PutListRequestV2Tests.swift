import TwitterAPIKit
import XCTest

class PutListRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PutListRequestV2(
            id: "_id_",
            description: "d",
            name: "n",
            private: true
        )

        XCTAssertEqual(req.method, .put)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/lists/_id_")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "description": "d",
                "name": "n",
                "private": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PutListRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
