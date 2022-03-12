import TwitterAPIKit
import XCTest

class PostOAuthRequestTokenRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostOAuthRequestTokenRequestV1(
            oauthCallback: "_o_",
            xAuthAccessType: "_x_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/oauth/request_token")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "oauth_callback": "_o_",
                "x_auth_access_type": "_x_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostOAuthRequestTokenRequestV1(
            oauthCallback: "_o_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "oauth_callback": "_o_"
            ]
        )
    }
}
