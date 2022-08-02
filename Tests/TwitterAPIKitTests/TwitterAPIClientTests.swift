import TwitterAPIKit
import XCTest

class TwitterAPIClientTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        MockURLProtocol.cleanup()
    }

    func testJSONDecoder() throws {

        let decoder = TwitterAPIClient.defaultJSONDecoder

        let dateV1 = try decoder.decode(Date.self, from: Data("\"Sun Jul 03 04:32:05 +0000 2022\"".utf8))
        let dateV2 = try decoder.decode(Date.self, from: Data("\"2022-07-03T04:32:05.000Z\"".utf8))
        XCTAssertEqual(dateV1, dateV2)
    }

    func testRefreshToken() throws {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]

        let client = TwitterAPIClient(
            .oauth20(
                .init(clientID: "c", scope: [], tokenType: "t", expiresIn: 0, accessToken: "a", refreshToken: "r")),
            configuration: config
        )

        MockURLProtocol.requestHandler = { request in
            let data = Data(
                #"""
                {
                "scope" : "tweet.write",
                "token_type" : "bearer",
                "expires_in" : 7200,
                "access_token" : "<token>",
                "refresh_token" : "<refresh token>"
                }
                """#.utf8)
            return (
                HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!, data
            )
        }

        if case let .oauth20(token) = client.apiAuth {
            XCTAssertEqual(token.accessToken, "a")
            XCTAssertEqual(token.refreshToken, "r")
        } else {
            XCTFail()
        }

        let exp = expectation(description: "")
        client.refreshOAuth20Token(type: .publicClient) { result in
            do {
                let newToken = try result.get()
                XCTAssertTrue(newToken.refreshed)
                XCTAssertEqual(newToken.token.accessToken, "<token>")
                XCTAssertEqual(newToken.token.refreshToken, "<refresh token>")
            } catch {
                XCTFail("Error: \(error)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)

        // check refresh
        if case let .oauth20(token) = client.apiAuth {
            XCTAssertEqual(token.accessToken, "<token>")
            XCTAssertEqual(token.refreshToken, "<refresh token>")
        } else {
            XCTFail()
        }
    }

    func testRefreshTokenForceRefresh() throws {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]

        let client = TwitterAPIClient(
            .oauth20(
                .init(clientID: "c", scope: [], tokenType: "t", expiresIn: 1000, accessToken: "a", refreshToken: "r")
            ),
            configuration: config
        )

        MockURLProtocol.requestHandler = { request in
            let data = Data(
                #"""
                {
                "scope" : "tweet.write",
                "token_type" : "bearer",
                "expires_in" : 7200,
                "access_token" : "<token>",
                "refresh_token" : "<refresh token>"
                }
                """#.utf8)
            return (
                HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!, data
            )
        }

        let exp = expectation(description: "")
        client.refreshOAuth20Token(type: .publicClient, forceRefresh: true) { result in
            do {
                let newToken = try result.get()
                XCTAssertTrue(newToken.refreshed)
                XCTAssertEqual(newToken.token.accessToken, "<token>")
                XCTAssertEqual(newToken.token.refreshToken, "<refresh token>")
            } catch {
                XCTFail("Error: \(error)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)

        // check refresh
        if case let .oauth20(token) = client.apiAuth {
            XCTAssertEqual(token.accessToken, "<token>")
            XCTAssertEqual(token.refreshToken, "<refresh token>")
        } else {
            XCTFail()
        }
    }
    func testRefreshToken_invalidAuthenticationMethod() throws {
        let client = TwitterAPIClient(.none)
        let exp = expectation(description: "")
        client.refreshOAuth20Token(type: .publicClient) { result in
            switch result {
            case .failure(.refreshOAuth20TokenFailed(reason: .invalidAuthenticationMethod(.none))):
                break
            default:
                XCTFail()
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }

    func testRefreshToken_refreshTokenIsMissing() throws {
        let client = TwitterAPIClient(
            .oauth20(
                .init(
                    clientID: "",
                    scope: [],
                    tokenType: "",
                    expiresIn: 0,
                    accessToken: "",
                    refreshToken: nil
                )))
        let exp = expectation(description: "")
        client.refreshOAuth20Token(type: .publicClient) { result in
            switch result {
            case .failure(.refreshOAuth20TokenFailed(reason: .refreshTokenIsMissing)):
                break
            default:
                XCTFail()
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }

    func testRefreshTokenNotExpired() throws {
        let now = Date()
        let client = TwitterAPIClient(
            .oauth20(
                .init(
                    clientID: "c",
                    scope: [],
                    tokenType: "t",
                    expiresIn: 100,
                    accessToken: "a",
                    refreshToken: "r",
                    createdAt: now
                )))

        let exp = expectation(description: "")
        client.refreshOAuth20Token(type: .publicClient) { result in
            switch result {
            case .success(let newToken):
                XCTAssertFalse(newToken.refreshed)
                XCTAssertEqual(newToken.token.clientID, "c")
                XCTAssertEqual(newToken.token.refreshToken, "r")
                XCTAssertEqual(newToken.token.createdAt, now)
            default:
                XCTFail()
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }

    #if compiler(>=5.5.2) && canImport(_Concurrency)

        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func testRefreshTokenAsync() async throws {
            let config = URLSessionConfiguration.default
            config.protocolClasses = [MockURLProtocol.self]

            let client = TwitterAPIClient(
                .oauth20(
                    .init(clientID: "c", scope: [], tokenType: "t", expiresIn: 0, accessToken: "a", refreshToken: "r")),
                configuration: config
            )

            MockURLProtocol.requestHandler = { request in
                let data = Data(
                    #"""
                    {
                    "scope" : "tweet.write",
                    "token_type" : "bearer",
                    "expires_in" : 7200,
                    "access_token" : "<token>",
                    "refresh_token" : "<refresh token>"
                    }
                    """#.utf8)
                return (
                    HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!, data
                )
            }

            let newToken = try await client.refreshOAuth20Token(type: .publicClient)
            XCTAssertTrue(newToken.refreshed)
            XCTAssertEqual(newToken.token.accessToken, "<token>")
            XCTAssertEqual(newToken.token.refreshToken, "<refresh token>")

            // check refresh
            if case let .oauth20(token) = client.apiAuth {
                XCTAssertEqual(token.accessToken, "<token>")
                XCTAssertEqual(token.refreshToken, "<refresh token>")
            } else {
                XCTFail()
            }
        }

        @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        func testRefreshTokenInvalidAuthenticationMethodAsync() async throws {
            let client = TwitterAPIClient(.none)

            do {
                _ = try await client.refreshOAuth20Token(type: .publicClient)
                XCTFail()
            } catch {
                switch error {
                case TwitterAPIKitError.refreshOAuth20TokenFailed(reason: .invalidAuthenticationMethod(.none)):
                    break
                default:
                    XCTFail()
                }
            }
        }
    #endif
}
