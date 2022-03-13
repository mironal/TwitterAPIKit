import TwitterAPIKit
import XCTest

class GetComplianceJobsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetComplianceJobsRequestV2(
            type: .tweets,
            status: .complete
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/compliance/jobs")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "type": "tweets",
                "status": "complete",
            ])
    }

    func testDefaultArg() throws {
        let req = GetComplianceJobsRequestV2(
            type: .users
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "type": "users"
            ])
    }
}
