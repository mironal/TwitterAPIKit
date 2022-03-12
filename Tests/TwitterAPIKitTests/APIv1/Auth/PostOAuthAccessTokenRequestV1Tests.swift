import TwitterAPIKit
import XCTest

class PostOAuthAccessTokenRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostOAuthAccessTokenRequestV1(
            oauthToken: "_ot_",
            oauthVerifier: "_ov_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/oauth/access_token")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "oauth_token": "_ot_",
                "oauth_verifier": "_ov_",
            ]
        )
    }
}
