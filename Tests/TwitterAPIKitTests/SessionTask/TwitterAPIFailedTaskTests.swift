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
        exp.expectedFulfillmentCount = 8
        task.responseData { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            dispatchPrecondition(condition: .onQueue(.main))
            exp.fulfill()
        }
        .responseData(queue: .global(qos: .utility)) { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            dispatchPrecondition(condition: .onQueue(.global(qos: .utility)))
            exp.fulfill()
        }
        .responseObject { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            dispatchPrecondition(condition: .onQueue(.main))
            exp.fulfill()
        }
        .responseObject(queue: .global(qos: .default)) { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            dispatchPrecondition(condition: .onQueue(.global(qos: .default)))
            exp.fulfill()
        }
        .responseDecodable(type: DecodableObj.self) { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            dispatchPrecondition(condition: .onQueue(.main))
            exp.fulfill()
        }
        .responseDecodable(type: DecodableObj.self, queue: .global(qos: .default)) { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            dispatchPrecondition(condition: .onQueue(.global(qos: .default)))
            exp.fulfill()
        }
        .responseDecodable(type: DecodableObj.self, decoder: JSONDecoder()) { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            dispatchPrecondition(condition: .onQueue(.main))
            exp.fulfill()
        }
        .responseDecodable(type: DecodableObj.self, decoder: JSONDecoder(), queue: .global(qos: .userInteractive)) {
            response in

            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            dispatchPrecondition(condition: .onQueue(.global(qos: .userInteractive)))
            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)
    }

    func testStream() throws {
        let task = TwitterAPIFailedTask(.responseFailed(reason: .invalidResponse(error: nil)))

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 2
        task.streamResponse { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            dispatchPrecondition(condition: .onQueue(.main))
            exp.fulfill()
        }
        .streamResponse(queue: .global(qos: .utility)) { response in
            XCTAssertNotNil(response.error)
            XCTAssertTrue(response.isError)
            dispatchPrecondition(condition: .onQueue(.global(qos: .utility)))
            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)
    }
}
