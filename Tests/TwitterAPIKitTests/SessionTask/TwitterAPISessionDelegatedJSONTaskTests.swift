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

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 6

        _ = task.responseData(queue: .global(qos: .background)) { response in

            XCTAssertEqual(response.success, Data("{\"key\":\"value\"}".utf8))

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
                url: URL(string: "http://example.com")!, statusCode: 200, httpVersion: "1.1", headerFields: [:])

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
                url: URL(string: "http://example.com")!, statusCode: 400, httpVersion: "1.1", headerFields: [:])

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
}
