import TwitterAPIKit
import XCTest

class GetApplicationRateLimitStatusRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetApplicationRateLimitStatusRequestV1(
            resources: ["a", "b"]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/application/rate_limit_status.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "resources": "a,b"
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetApplicationRateLimitStatusRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
