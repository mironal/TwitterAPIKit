import TwitterAPIKit
import XCTest

class TwitterRateLimitTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        XCTContext.runActivity(named: "from int") { _ in
            let header = [
                "x-rate-limit-limit": 15,
                "x-rate-limit-remaining": 13,
                "x-rate-limit-reset": 1_644_417_523,
            ]

            let rateLimit = TwitterRateLimit(header: header)!

            XCTAssertEqual(rateLimit.limit, 15)
            XCTAssertEqual(rateLimit.remaining, 13)
            XCTAssertEqual(rateLimit.reset, 1_644_417_523)
            XCTAssertEqual(rateLimit.resetDate.timeIntervalSince1970, 1_644_417_523)
        }

        XCTContext.runActivity(named: "from string") { _ in
            let header = [
                "x-rate-limit-limit": "15",
                "x-rate-limit-remaining": "3",
                "x-rate-limit-reset": "1644417524",
            ]

            let rateLimit = TwitterRateLimit(header: header)!

            XCTAssertEqual(rateLimit.limit, 15)
            XCTAssertEqual(rateLimit.remaining, 3)
            XCTAssertEqual(rateLimit.reset, 1_644_417_524)
        }

    }

    func testNil() throws {
        XCTContext.runActivity(named: "limit") { _ in
            let header = [
                "x-rate-limit-remaining": "3",
                "x-rate-limit-reset": "1644417524",
            ]

            XCTAssertNil(TwitterRateLimit(header: header))
        }
        XCTContext.runActivity(named: "remaining") { _ in
            let header = [
                "x-rate-limit-limit": "15",
                "x-rate-limit-reset": "1644417524",
            ]

            XCTAssertNil(TwitterRateLimit(header: header))
        }

        XCTContext.runActivity(named: "reset") { _ in
            let header = [
                "x-rate-limit-limit": "15",
                "x-rate-limit-remaining": "3",
            ]

            XCTAssertNil(TwitterRateLimit(header: header))
        }

    }

}
