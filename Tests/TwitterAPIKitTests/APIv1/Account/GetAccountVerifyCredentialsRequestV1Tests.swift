import TwitterAPIKit
import XCTest

class GetAccountVerifyCredentialsRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetAccountVerifyCredentialsRequestV1(
            skipStatus: true,
            includeEmail: true,
            includeEntities: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/account/verify_credentials.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "skip_status": true,
                "include_email": true,
                "include_entities": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetAccountVerifyCredentialsRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
