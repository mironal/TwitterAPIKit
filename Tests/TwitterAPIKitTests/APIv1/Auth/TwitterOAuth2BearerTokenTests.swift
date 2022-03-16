import TwitterAPIKit
import XCTest

class TwitterOAuth2BearerTokenTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testJsonData() throws {

        let data = Data(#"{"token_type":"bearer","access_token":"token"}"#.utf8)
        let token = try TwitterOAuth2BearerToken(jsonData: data)!

        XCTAssertEqual(token.tokenType, "bearer")
        XCTAssertEqual(token.accessToken, "token")
    }
}
