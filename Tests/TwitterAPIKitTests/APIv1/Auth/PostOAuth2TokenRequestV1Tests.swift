import TwitterAPIKit
import XCTest

class PostOAuth2TokenRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostOAuth2TokenRequestV1(
            grantType: "_g_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/oauth2/token")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "grant_type": "_g_"
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostOAuth2TokenRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [
                "grant_type": "client_credentials"
            ]
        )
    }
}
