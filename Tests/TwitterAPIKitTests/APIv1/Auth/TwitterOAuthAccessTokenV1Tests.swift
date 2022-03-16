import TwitterAPIKit
import XCTest

class TwitterOAuthAccessTokenV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        let token = TwitterOAuthAccessTokenV1(
            oauthToken: "token", oauthTokenSecret: "secret", userID: "uid", screenName: "sn")
        XCTAssertEqual(token.oauthToken, "token")
        XCTAssertEqual(token.oauthTokenSecret, "secret")
        XCTAssertEqual(token.userID, "uid")
        XCTAssertEqual(token.screenName, "sn")
    }

    func testQueryStringData() throws {
        let data = Data(
            "oauth_token=token&oauth_token_secret=secret&user_id=uid&screen_name=name"
                .utf8)

        let token = TwitterOAuthAccessTokenV1(queryStringData: data)!

        XCTAssertEqual(token.oauthToken, "token")
        XCTAssertEqual(token.oauthTokenSecret, "secret")
        XCTAssertEqual(token.userID, "uid")
        XCTAssertEqual(token.screenName, "name")
    }

    func testNil() throws {
        let data = Data("".utf8)
        XCTAssertNil(TwitterOAuthAccessTokenV1(queryStringData: data))
    }
}
