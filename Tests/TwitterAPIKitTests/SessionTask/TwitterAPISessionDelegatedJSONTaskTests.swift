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
        exp.expectedFulfillmentCount = 3

        _ = task.responseData(queue: .global(qos: .background)) { response in

            XCTAssertEqual(response.success, Data("{\"key\":\"value\"}".utf8))

            exp.fulfill()
        }.responseObject(queue: .global(qos: .background)) { response in
            AssertEqualAnyDict(response.success as! [String: Any], ["key": "value"])
            exp.fulfill()
        }.responseDecodable(type: DecodableObj.self, queue: .global(qos: .background)) { response in
            XCTAssertEqual(response.success, .init(key: "value"))
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
}
