import XCTest

@testable import TwitterAPIKit

class TwitterOAuth2AccessTokenTests: XCTestCase {

    func test() throws {
        try XCTContext.runActivity(named: "without refresh_token") { _ in

            let data = Data(
                #"""
                {
                "scope" : "tweet.write tweet.read",
                "token_type" : "bearer",
                "expires_in" : 7200,
                "access_token" : "<token>"
                }
                """#.utf8)
            let token = try TwitterOAuth2AccessToken(jsonData: data)!
            XCTAssertEqual(token.scope, ["tweet.write", "tweet.read"])
            XCTAssertEqual(token.tokenType, "bearer")
            XCTAssertEqual(token.expiresIn, 7200)
            XCTAssertEqual(token.accessToken, "<token>")
            XCTAssertNil(token.refreshToken)
        }

        try XCTContext.runActivity(named: "with refresh_token") { _ in

            let data = Data(
                #"""
                {
                "scope" : "tweet.write tweet.read offline.access",
                "token_type" : "bearer",
                "expires_in" : 7200,
                "access_token" : "<token>",
                "refresh_token" : "<refresh token>"
                }
                """#.utf8)
            let token = try TwitterOAuth2AccessToken(jsonData: data)!
            XCTAssertEqual(token.scope, ["tweet.write", "tweet.read", "offline.access"])
            XCTAssertEqual(token.tokenType, "bearer")
            XCTAssertEqual(token.expiresIn, 7200)
            XCTAssertEqual(token.accessToken, "<token>")
            XCTAssertEqual(token.refreshToken, "<refresh token>")
        }
    }

    func testError() throws {

        try XCTContext.runActivity(named: "Not json") { _ in
            XCTAssertThrowsError(try TwitterOAuth2AccessToken.fromResponse(data: Data("aa".utf8))) { error in
                XCTAssertTrue((error as! TwitterAPIKitError).isResponseSerializeFailed)
            }
        }

        try XCTContext.runActivity(named: "valid json but invalid object") { _ in
            XCTAssertThrowsError(try TwitterOAuth2AccessToken.fromResponse(data: Data("{}".utf8))) { error in
                XCTAssertTrue((error as! TwitterAPIKitError).isResponseSerializeFailed)
            }
        }
    }
}
