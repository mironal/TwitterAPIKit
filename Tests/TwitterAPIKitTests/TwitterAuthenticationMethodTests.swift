import TwitterAPIKit
import XCTest

final class TwitterAuthenticationMethodTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    // MARK: - OAuth10a

    func testOAuth10aInit() throws {

        let oauth10 = TwitterAuthenticationMethod.OAuth10a(
            consumerKey: "ck",
            consumerSecret: "cs",
            oauthToken: "t",
            oauthTokenSecret: "ts"
        )

        XCTAssertEqual(oauth10.consumerKey, "ck")
        XCTAssertEqual(oauth10.consumerSecret, "cs")
        XCTAssertEqual(oauth10.oauthToken, "t")
        XCTAssertEqual(oauth10.oauthTokenSecret, "ts")

    }

    // MARK: - OAuth20

    func testOAuth20Init() throws {

        do {
            let createdAt = Date(timeIntervalSince1970: 2)

            let oauth20 = TwitterAuthenticationMethod.OAuth20(
                clientID: "client_id",
                scope: ["scope"],
                tokenType: "token_type",
                expiresIn: 10,
                accessToken: "access_token",
                refreshToken: "refresh_token",
                createdAt: createdAt
            )

            XCTAssertEqual(oauth20.clientID, "client_id")
            XCTAssertEqual(oauth20.scope, ["scope"])
            XCTAssertEqual(oauth20.tokenType, "token_type")
            XCTAssertEqual(oauth20.expiresIn, 10)
            XCTAssertEqual(oauth20.accessToken, "access_token")
            XCTAssertEqual(oauth20.refreshToken, "refresh_token")
            XCTAssertEqual(oauth20.createdAt, createdAt)
        }

        do {
            let createdAt = Date(timeIntervalSince1970: 3)
            let tokenJSON = Data(
                """
                            {
                                "refresh_token" : "<refresh token>",
                                "scope" : "tweet.write tweet.read offline.access",
                                "token_type" : "bearer",
                                "expires_in" : 7200,
                                "access_token" : "<token>"
                            }
                """.utf8)
            let token = try TwitterOAuth2AccessToken(jsonData: tokenJSON)!
            let oauth20 = TwitterAuthenticationMethod.OAuth20(
                clientID: "_client_id_",
                token: token,
                createdAt: createdAt
            )

            XCTAssertEqual(oauth20.clientID, "_client_id_")
            XCTAssertEqual(oauth20.scope, ["tweet.write", "tweet.read", "offline.access"])
            XCTAssertEqual(oauth20.tokenType, "bearer")
            XCTAssertEqual(oauth20.expiresIn, 7200)
            XCTAssertEqual(oauth20.accessToken, "<token>")
            XCTAssertEqual(oauth20.refreshToken, "<refresh token>")
            XCTAssertEqual(oauth20.createdAt, createdAt)
        }
    }

    func testOAuth20Refresh() throws {
        let createdAt = Date(timeIntervalSince1970: 2)

        var oauth20 = TwitterAuthenticationMethod.OAuth20(
            clientID: "client_id",
            scope: ["scope"],
            tokenType: "token_type",
            expiresIn: 10,
            accessToken: "access_token",
            refreshToken: "refresh_token",
            createdAt: createdAt
        )

        XCTAssertEqual(oauth20.refreshToken, "refresh_token")
        XCTAssertEqual(oauth20.createdAt, createdAt)

        let refreshedAt = Date(timeIntervalSince1970: 3)
        let tokenJSON = Data(
            """
                        {
                            "refresh_token" : "<refresh token>",
                            "scope" : "tweet.write tweet.read offline.access",
                            "token_type" : "bearer",
                            "expires_in" : 7200,
                            "access_token" : "<token>"
                        }
            """.utf8)
        let token = try TwitterOAuth2AccessToken(jsonData: tokenJSON)!

        oauth20.refresh(token: token, refreshedAt: refreshedAt)

        XCTAssertEqual(oauth20.clientID, "client_id")
        XCTAssertEqual(oauth20.scope, ["tweet.write", "tweet.read", "offline.access"])
        XCTAssertEqual(oauth20.tokenType, "bearer")
        XCTAssertEqual(oauth20.expiresIn, 7200)
        XCTAssertEqual(oauth20.accessToken, "<token>")
        XCTAssertEqual(oauth20.refreshToken, "<refresh token>")
        XCTAssertEqual(oauth20.createdAt, refreshedAt)
    }

    func testOAuth20Expired() throws {
        let createdAt = Date(timeIntervalSince1970: 0)
        let oauth20 = TwitterAuthenticationMethod.OAuth20(
            clientID: "",
            scope: [],
            tokenType: "",
            expiresIn: 10,
            accessToken: "",
            refreshToken: "",
            createdAt: createdAt
        )

        XCTAssertEqual(oauth20.expiresAt, createdAt.addingTimeInterval(10))
        XCTAssertTrue(oauth20.expired)
    }

    func testOAuth20NotExpired() throws {
        let createdAt = Date()
        let oauth20 = TwitterAuthenticationMethod.OAuth20(
            clientID: "",
            scope: [],
            tokenType: "",
            expiresIn: 10,
            accessToken: "",
            refreshToken: "",
            createdAt: createdAt
        )

        XCTAssertEqual(oauth20.expiresAt, createdAt.addingTimeInterval(10))
        XCTAssertFalse(oauth20.expired)
    }
}
