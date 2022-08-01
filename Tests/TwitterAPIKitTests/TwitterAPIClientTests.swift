import TwitterAPIKit
import XCTest

class TwitterAPIClientTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testJSONDecoder() throws {

        let decoder = TwitterAPIClient.defaultJSONDecoder

        let dateV1 = try decoder.decode(Date.self, from: Data("\"Sun Jul 03 04:32:05 +0000 2022\"".utf8))
        let dateV2 = try decoder.decode(Date.self, from: Data("\"2022-07-03T04:32:05.000Z\"".utf8))
        XCTAssertEqual(dateV1, dateV2)
    }

    func testRefreshInvalidAuthMethod() throws {
        let client = TwitterAPIClient(.none)
        let exp = expectation(description: "")
        client.refreshOAuth20Token(type: .publicClient) { result in
            switch result {
            case .failure(let error):
                XCTAssertTrue(error.isRefreshOAuth20TokenFailed)
            default:
                XCTFail()
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }

    func testRefreshTokenMissingRefreshToken() throws {
        let client = TwitterAPIClient(
            .oauth20(.init(clientID: "", scope: [], tokenType: "", expiresIn: 0, accessToken: "", refreshToken: nil)))
        let exp = expectation(description: "")
        client.refreshOAuth20Token(type: .publicClient) { result in
            switch result {
            case .failure(let error):
                XCTAssertTrue(error.isRefreshOAuth20TokenFailed)
            default:
                XCTFail()
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
}
