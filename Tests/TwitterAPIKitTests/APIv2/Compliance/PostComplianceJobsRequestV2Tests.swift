import TwitterAPIKit
import XCTest

class PostComplianceJobsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostComplianceJobsRequestV2(
            type: .tweets,
            name: "n",
            resumable: true
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/compliance/jobs")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "type": "tweets",
                "name": "n",
                "resumable": true,
            ])
    }

    func testDefaultArg() throws {
        let req = PostComplianceJobsRequestV2(
            type: .users
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "type": "users"
            ])
    }
}
