import XCTest

@testable import TwitterAPIKit

struct DecodableObj: Decodable, Equatable {
    let key: String
}

class TwitterAPISessionDelegatedJSONTaskTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testSuccess() throws {
        let mockTask = MockTwitterAPISessionTask(taskIdentifier: 1)

        let task = TwitterAPISessionDelegatedJSONTask(
            task: mockTask
        )

        XCTAssertEqual(task.taskIdentifier, 1)

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 6

        _ = task.responseData(queue: .global(qos: .background)) { response in

            XCTAssertEqual(response.success, Data("{\"key\":\"value\"}".utf8))
            XCTAssertNotNil(response.rateLimit)
            XCTAssertEqual(response.rateLimit?.limit, 15)
            XCTAssertEqual(response.rateLimit?.remaining, 1)
            XCTAssertEqual(response.rateLimit?.reset, 1_647_099_944)

            XCTAssertFalse(Thread.isMainThread)
            exp.fulfill()
        }
        .responseData { _ in
            XCTAssertTrue(Thread.isMainThread)
            exp.fulfill()
        }
        .responseObject(queue: .global(qos: .background)) { response in
            AssertEqualAnyDict(response.success as! [String: Any], ["key": "value"])
            XCTAssertFalse(Thread.isMainThread)
            exp.fulfill()
        }
        .responseObject { _ in
            XCTAssertTrue(Thread.isMainThread)
            exp.fulfill()
        }
        .responseDecodable(type: DecodableObj.self, queue: .global(qos: .background)) { response in
            XCTAssertEqual(response.success, .init(key: "value"))
            XCTAssertFalse(Thread.isMainThread)
            exp.fulfill()
        }
        .responseDecodable(type: DecodableObj.self) { _ in
            XCTAssertTrue(Thread.isMainThread)
            exp.fulfill()
        }

        DispatchQueue.global(qos: .background).async {
            task.append(chunk: Data("{\"key\"".utf8))
            task.append(chunk: Data(":\"value\"}".utf8))

            mockTask.httpResponse = .init(
                url: URL(string: "http://example.com")!,
                statusCode: 200,
                httpVersion: "1.1",
                headerFields: [
                    "x-rate-limit-limit": "15",
                    "x-rate-limit-remaining": "1",
                    "x-rate-limit-reset": "1647099944",
                ]
            )

            task.complete(error: nil)
        }

        wait(for: [exp], timeout: 10)
    }

    func testInvalidStatusCode() throws {
        let mockTask = MockTwitterAPISessionTask(taskIdentifier: 1)

        let task = TwitterAPISessionDelegatedJSONTask(
            task: mockTask
        )

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 3

        _ = task.responseData(queue: .global(qos: .background)) { response in
            XCTAssertTrue(response.isError)
            XCTAssertNotNil(response.rateLimit)
            XCTAssertEqual(response.rateLimit?.limit, 100)
            XCTAssertEqual(response.rateLimit?.remaining, 2)
            XCTAssertEqual(response.rateLimit?.reset, 1_647_099_945)

            exp.fulfill()
        }.responseObject(queue: .global(qos: .background)) { response in
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }.responseDecodable(type: DecodableObj.self, queue: .global(qos: .background)) { response in
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }

        DispatchQueue.global(qos: .background).async {
            task.append(chunk: Data("{\"key\"".utf8))
            task.append(chunk: Data(":\"value\"}".utf8))

            // Status code is 400
            mockTask.httpResponse = .init(
                url: URL(string: "http://example.com")!,
                statusCode: 400,
                httpVersion: "1.1",
                headerFields: [
                    "x-rate-limit-limit": "100",
                    "x-rate-limit-remaining": "2",
                    "x-rate-limit-reset": "1647099945",
                ]
            )

            task.complete(error: nil)
        }

        wait(for: [exp], timeout: 10)
    }

    func testCompleteWithError() throws {

        let mockTask = MockTwitterAPISessionTask(taskIdentifier: 1)

        let task = TwitterAPISessionDelegatedJSONTask(
            task: mockTask
        )

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 3

        _ = task.responseData(queue: .global(qos: .background)) { response in
            XCTAssertTrue(response.isError)
            XCTAssertEqual(response.error?.underlyingError as! URLError, URLError(.badServerResponse))
            exp.fulfill()
        }.responseObject(queue: .global(qos: .background)) { response in
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }.responseDecodable(type: DecodableObj.self, queue: .global(qos: .background)) { response in
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }

        DispatchQueue.global(qos: .background).async {
            task.append(chunk: Data("{\"key\"".utf8))
            task.append(chunk: Data(":\"value\"}".utf8))

            mockTask.httpResponse = .init(
                url: URL(string: "http://example.com")!, statusCode: 200, httpVersion: "1.1", headerFields: [:])

            task.complete(error: URLError.init(.badServerResponse))
        }

        wait(for: [exp], timeout: 10)
    }

    func testCancel() throws {

        let mockTask = MockTwitterAPISessionTask(taskIdentifier: 1)

        let task = TwitterAPISessionDelegatedJSONTask(
            task: mockTask
        )

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 3

        _ = task.responseData(queue: .global(qos: .background)) { response in
            XCTAssertTrue(response.isError)
            XCTAssertEqual(response.error?.underlyingError as! URLError, URLError(.cancelled))
            exp.fulfill()
        }.responseObject(queue: .global(qos: .background)) { response in
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }.responseDecodable(type: DecodableObj.self, queue: .global(qos: .background)) { response in
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }

        DispatchQueue.global(qos: .background).async {
            task.append(chunk: Data("{\"key\"".utf8))
            task.append(chunk: Data(":\"value\"}".utf8))

            mockTask.httpResponse = .init(
                url: URL(string: "http://example.com")!, statusCode: 200, httpVersion: "1.1", headerFields: [:])

            task.complete(error: URLError.init(.cancelled))
        }

        task.cancel()

        wait(for: [exp], timeout: 10)
        XCTAssertTrue(mockTask.cancelled)
    }

    func testEXC_BAD_INSTRUCTION() throws {
        // EXC_BAD_INSTRUCTION will occur if the Dispatch Queue is released while suspended.
        let mockTask = MockTwitterAPISessionTask(taskIdentifier: 1)
        _ = TwitterAPISessionDelegatedJSONTask(task: mockTask)
    }
}
