import XCTest

@testable import TwitterAPIKit

class TwitterAPISessionSpecializedTaskTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        let mockTask = MockTwitterAPISessionDataTask(
            data: Data("hoge".utf8), taskIdentifier: 10, currentRequest: nil, originalRequest: nil, httpResponse: nil
        )

        let task = TwitterAPISessionSpecializedTask(task: mockTask) { data in
            return String(data: data, encoding: .utf8)!
        }

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 2
        task.responseObject(queue: .main) { response in
            XCTAssertEqual(response.success, "hoge")
            exp.fulfill()
        }.responseData { response in
            XCTAssertEqual(response.success, Data("hoge".utf8))
            exp.fulfill()
        }

        wait(for: [exp], timeout: 100)
    }

    func testArray() throws {

        let mockTask1 = MockTwitterAPISessionDataTask(
            data: Data("hoge1".utf8), taskIdentifier: 10, currentRequest: nil, originalRequest: nil, httpResponse: nil
        )
        let mockTask2 = MockTwitterAPISessionDataTask(
            data: Data("hoge2".utf8), taskIdentifier: 10, currentRequest: nil, originalRequest: nil, httpResponse: nil
        )

        let task1 = TwitterAPISessionSpecializedTask(task: mockTask1) { data in
            return String(data: data, encoding: .utf8)!
        }

        let task2 = TwitterAPISessionSpecializedTask(task: mockTask2) { data in
            return String(data: data, encoding: .utf8)!
        }

        let exp = expectation(description: "")

        [task1, task2].responseObject { responses in
            XCTAssertEqual(responses.count, 2)
            XCTAssertEqual(responses[0].success, "hoge1")
            XCTAssertEqual(responses[1].success, "hoge2")

            exp.fulfill()
        }

        wait(for: [exp], timeout: 100)
    }
}
