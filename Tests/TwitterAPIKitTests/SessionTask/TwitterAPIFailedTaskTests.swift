import TwitterAPIKit
import XCTest

class TwitterAPIFailedTaskTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        let response = TwitterAPIFailedTask(.responseFailed(reason: .invalidResponse(error: nil)))

        XCTAssertTrue(response.error.isResponseFailed)
        XCTAssertEqual(response.taskIdentifier, -1)
        XCTAssertNil(response.currentRequest)
        XCTAssertNil(response.originalRequest)
        XCTAssertNil(response.httpResponse)

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 3
        response.responseData { response in
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }
        .responseObject { response in
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }
        .responseDecodable(type: DecodableObj.self, decoder: JSONDecoder()) { response in
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)
    }
}
