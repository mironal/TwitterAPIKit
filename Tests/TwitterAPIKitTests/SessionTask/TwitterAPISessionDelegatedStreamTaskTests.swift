import XCTest

@testable import TwitterAPIKit

class TwitterAPISessionDelegatedStreamTaskTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        let mockTask = MockTwitterAPISessionTask(
            taskIdentifier: 1,
            currentRequest: nil,
            originalRequest: nil,
            httpResponse: nil
        )

        let task = TwitterAPISessionDelegatedStreamTask(task: mockTask)

        DispatchQueue.main.async {
            task.append(chunk: Data("aaaa\r\nbbbb".utf8))
            task.append(chunk: Data("🥓🥓\r\nあ".utf8))

            task.complete(error: nil)
        }

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 4

        var count = 0
        task.streamResponse { response in

            switch count {
            case 0:
                XCTAssertEqual(response.success.map { String(data: $0, encoding: .utf8) }, "aaaa")
            case 1:
                XCTAssertEqual(response.success.map { String(data: $0, encoding: .utf8) }, "bbbb")
            case 2:
                XCTAssertEqual(response.success.map { String(data: $0, encoding: .utf8) }, "🥓🥓")
            case 3:
                XCTAssertEqual(response.success.map { String(data: $0, encoding: .utf8) }, "あ")
            default:
                XCTFail()
            }

            count += 1
            exp.fulfill()
        }

        wait(for: [exp], timeout: 100)
        XCTAssertEqual(count, 4)
    }
}
