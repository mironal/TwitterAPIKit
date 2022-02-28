import TwitterAPIKit
import XCTest

class TwitterAPIResponseTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        let rateLimit = TwitterRateLimit(header: [
            "x-rate-limit-limit": "10",
            "x-rate-limit-remaining": "1",
            "x-rate-limit-reset": "10000",
        ])
        let data = Data("{}".utf8)
        let url = URL(string: "https://example.com")!

        let response: TwitterAPIResponse<Data> = TwitterAPIResponse(
            request: .init(url: url),
            response: .init(url: url, statusCode: 200, httpVersion: "1.1", headerFields: [:]),
            data: data,
            result: .success(data),
            rateLimit: rateLimit
        )

        XCTAssertEqual(response.request?.url, url)
        XCTAssertEqual(response.response?.url, url)
        XCTAssertEqual(response.success, data)
        XCTAssertEqual(try response.result.get(), data)
        XCTAssertNil(response.error)
        XCTAssertFalse(response.isError)
        XCTAssertTrue(response.prettyString.hasPrefix("-- Request success --"))

        XCTContext.runActivity(named: "map") { _ in
            let mapped = response.map { data in
                return try! JSONSerialization.jsonObject(with: data, options: [])
            }
            XCTAssertEqual(mapped.success as! [String: String], [:])
        }

        XCTContext.runActivity(named: "tryMap") { _ in
            let mapped = response.tryMap { data in
                return try JSONSerialization.jsonObject(with: data, options: [])
            }
            XCTAssertEqual(mapped.success as! [String: String], [:])
        }

        XCTContext.runActivity(named: "tryMapWithError") { _ in
            let mapped = response.tryMap { _ in
                throw NSError(domain: "", code: 0, userInfo: nil)
            }
            XCTAssertTrue(mapped.isError)
            XCTAssertTrue(mapped.error!.isUnkonwn)
            XCTAssertTrue(mapped.prettyString.hasPrefix("-- Request failure --"))

            XCTContext.runActivity(named: "mapError") { _ in
                let errored = mapped.mapError { error in
                    return .responseFailed(reason: .invalidResponse(error: nil))
                }

                XCTAssertTrue(errored.error!.isResponseFailed)
            }
        }

        XCTContext.runActivity(named: "mapError") { _ in
            let mapped = response.mapError { _ in
                XCTFail("do not call")
                fatalError()
            }

            XCTAssertNotNil(mapped.success)
        }
    }
}
