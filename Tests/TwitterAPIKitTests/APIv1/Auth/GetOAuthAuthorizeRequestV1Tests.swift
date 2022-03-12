import TwitterAPIKit
import XCTest

class GetOAuthAuthorizeRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetOAuthAuthorizeRequestV1(
            oauthToken: "_o_",
            forceLogin: true,
            screenName: "_s_"
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/oauth/authorize")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "oauth_token": "_o_",
                "force_login": true,
                "screen_name": "_s_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetOAuthAuthorizeRequestV1(
            oauthToken: "_o_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "oauth_token": "_o_"
            ]
        )
    }
}
