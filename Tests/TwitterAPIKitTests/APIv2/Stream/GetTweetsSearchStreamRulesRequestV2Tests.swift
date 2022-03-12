import TwitterAPIKit
import XCTest

class GetTweetsSearchStreamRulesRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetTweetsSearchStreamRulesRequestV2(
            ids: ["10", "20"]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/tweets/search/stream/rules")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "ids": "10,20"
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetTweetsSearchStreamRulesRequestV2()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
