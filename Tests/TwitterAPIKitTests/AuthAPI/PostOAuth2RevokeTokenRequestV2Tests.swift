import TwitterAPIKit
import XCTest

class PostOAuth2RevokeTokenRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostOAuth2RevokeTokenRequestV2(
            token: "_t_",
            clientID: "_c_",
            tokenTypeHint: "hint"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/oauth2/revoke")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "token": "_t_",
                "client_id": "_c_",
                "token_type_hint": "hint",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostOAuth2RevokeTokenRequestV2(
            token: "_tt_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "token": "_tt_"
            ]
        )
    }
}
