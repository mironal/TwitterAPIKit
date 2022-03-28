import TwitterAPIKit
import XCTest

class AuthAPIv1Tests: XCTestCase {

    var client: AuthAPIv1!

    override func setUpWithError() throws {

        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]

        client =
            TwitterAPIKit(
                .oauth(consumerKey: "", consumerSecret: "", oauthToken: "", oauthTokenSecret: ""),
                configuration: config
            ).v1

    }

    override func tearDownWithError() throws {
        MockURLProtocol.cleanup()
    }

    func testMakeOAuthAuthorizeURL() throws {
        let url = client.makeOAuthAuthorizeURL(.init(oauthToken: "token", forceLogin: true, screenName: "name"))
        XCTAssertEqual(
            url?.absoluteString,
            "https://api.twitter.com/oauth/authorize?force_login=true&oauth_token=token&screen_name=name")
    }

    func testMakeOAuthAuthenticateURL() throws {
        let url = client.makeOAuthAuthenticateURL(.init(oauthToken: "token", forceLogin: true, screenName: "name"))
        XCTAssertEqual(
            url?.absoluteString,
            "https://api.twitter.com/oauth/authenticate?force_login=true&oauth_token=token&screen_name=name")
    }
}
