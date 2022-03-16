import TwitterAPIKit
import XCTest

class TwitterOAuthTokenV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        let token = TwitterOAuthTokenV1(oauthToken: "token", oauthTokenSecret: "secret", oauthCallbackConfirmed: true)
        XCTAssertEqual(token.oauthToken, "token")
        XCTAssertEqual(token.oauthTokenSecret, "secret")
        XCTAssertTrue(token.oauthCallbackConfirmed!)
    }

    func testQueryStringData() {

        let data = Data("oauth_token=token&oauth_token_secret=secret&oauth_callback_confirmed=true".utf8)
        let token = TwitterOAuthTokenV1(queryStringData: data)!

        XCTAssertEqual(token.oauthToken, "token")
        XCTAssertEqual(token.oauthTokenSecret, "secret")
        XCTAssertTrue(token.oauthCallbackConfirmed!)
    }

    func testNil() {
        let data = Data("".utf8)
        XCTAssertNil(TwitterOAuthTokenV1(queryStringData: data))
    }
}
