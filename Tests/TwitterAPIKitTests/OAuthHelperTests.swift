import XCTest

@testable import TwitterAPIKit

class OAuthHelperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // https://developer.twitter.com/en/docs/authentication/oauth-1-0a/authorizing-a-request
    // https://developer.twitter.com/en/docs/authentication/oauth-1-0a/creating-a-signature
    func test() throws {

        let header = authorizationHeader(
            for: .post,
            url: URL(string: "https://api.twitter.com/1.1/statuses/update.json")!,
            parameters: ["status": "Hello Ladies + Gentlemen, a signed OAuth request!", "include_entities": true],
            consumerKey: "xvz1evFS4wEEPTGEFPHBog",
            consumerSecret: "kAcSOqF21Fu85e7zjz7ZN2U4ZRhfV3WpwPAoE3Z7kBw",
            oauthToken: "370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb",
            oauthTokenSecret: "LswwdoUaIvS8ltyTt5jkRh4J50vUPVVHtR2YPi5kE",
            oauthTimestamp: "1318622958",
            oauthNonce: "kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg"
        )

        XCTAssertEqual(
            header,
            #"OAuth oauth_consumer_key="xvz1evFS4wEEPTGEFPHBog", oauth_nonce="kYjzVBB8Y0ZFabxSWbWovY3uYSQ2pTgmZeNu2VS4cg", oauth_signature="hCtSmYh%2BiHYCEqBWrE7C7hYmtUk%3D", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1318622958", oauth_token="370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb", oauth_version="1.0""#
        )

    }
}
