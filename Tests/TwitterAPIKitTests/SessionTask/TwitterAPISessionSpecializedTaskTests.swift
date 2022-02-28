import TwitterAPIKit
import XCTest

class TwitterAPISessionSpecializedTaskTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        let mockTask = MockTwitterAPISessionDataTask(
            data: Data("hoge".utf8), taskIdentifier: 10, currentRequest: nil, originalRequest: nil, httpResponse: nil)

        let task = TwitterAPISessionSpecializedTask(task: mockTask) { data in
            return String(data: data, encoding: .utf8)!
        }

        let exp = expectation(description: "")
        task.responseObject(queue: .main) { response in
            XCTAssertEqual(response.success, "hoge")
            exp.fulfill()
        }

        wait(for: [exp], timeout: 100)
    }
}
