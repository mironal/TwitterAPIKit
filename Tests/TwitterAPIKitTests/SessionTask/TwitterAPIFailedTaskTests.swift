import TwitterAPIKit
import XCTest

class TwitterAPIFailedTaskTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        let task = TwitterAPIFailedTask(.responseFailed(reason: .invalidResponse(error: nil)))

        XCTAssertTrue(task.error.isResponseFailed)
        XCTAssertEqual(task.taskIdentifier, -1)
        XCTAssertNil(task.currentRequest)
        XCTAssertNil(task.originalRequest)
        XCTAssertNil(task.httpResponse)

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 4
        task.responseData { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }
        .responseObject(queue: .global(qos: .default)) { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }
        .responseObject { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }
        .responseDecodable(type: DecodableObj.self, decoder: JSONDecoder()) { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)
    }
}
