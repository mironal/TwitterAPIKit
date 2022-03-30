import TwitterAPIKit
import XCTest

class TwitterAuthAPITests: XCTestCase {

    var client: TwitterAuthAPI!

    override func setUpWithError() throws {

        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]

        client =
            TwitterAPIKit(
                .oauth(consumerKey: "", consumerSecret: "", oauthToken: "", oauthTokenSecret: ""),
                configuration: config
            ).auth
    }

    override func tearDownWithError() throws {
        MockURLProtocol.cleanup()
    }

    func testMakeOAuthAuthorizeURL() throws {
        let url = client.oauth11a.makeOAuthAuthorizeURL(
            .init(oauthToken: "token", forceLogin: true, screenName: "name")
        )
        XCTAssertEqual(
            url?.absoluteString,
            "https://api.twitter.com/oauth/authorize?force_login=true&oauth_token=token&screen_name=name")
    }

    func testMakeOAuthAuthenticateURL() throws {
        let url = client.oauth11a.makeOAuthAuthenticateURL(
            .init(oauthToken: "token", forceLogin: true, screenName: "name")
        )
        XCTAssertEqual(
            url?.absoluteString,
            "https://api.twitter.com/oauth/authenticate?force_login=true&oauth_token=token&screen_name=name")
    }
}
