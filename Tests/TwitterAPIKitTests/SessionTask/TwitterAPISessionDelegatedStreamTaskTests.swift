import XCTest

@testable import TwitterAPIKit

class TwitterAPISessionDelegatedStreamTaskTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testProps() throws {
        let cReq = URLRequest(url: URL(string: "http://example.com/current")!)
        let oReq = URLRequest(url: URL(string: "http://example.com/original")!)
        let resp = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: "1.1",
            headerFields: [:]
        )
        let mockTask = MockTwitterAPISessionTask(
            taskIdentifier: 1,
            currentRequest: cReq,
            originalRequest: oReq,
            httpResponse: resp
        )

        let task = TwitterAPISessionDelegatedStreamTask(task: mockTask)

        XCTAssertEqual(mockTask.currentRequest, cReq)
        XCTAssertEqual(mockTask.originalRequest, oReq)
        XCTAssertEqual(task.httpResponse, resp)

    }

    func test() throws {

        let mockTask = MockTwitterAPISessionTask(
            taskIdentifier: 1,
            currentRequest: nil,
            originalRequest: nil,
            httpResponse: HTTPURLResponse(
                url: URL(string: "https://example.com")!,
                statusCode: 200,
                httpVersion: "1.1",
                headerFields: [
                    "x-rate-limit-limit": "15",
                    "x-rate-limit-remaining": "1",
                    "x-rate-limit-reset": "1647099944",
                ]
            )
        )

        let task = TwitterAPISessionDelegatedStreamTask(task: mockTask)

        DispatchQueue.main.async {

            task.append(chunk: Data("aaaa\r\nbbbb".utf8))
            task.append(chunk: Data("🥓🥓\r\nあ".utf8))
            task.complete(error: nil)
        }

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 8

        var count = 0
        task.streamResponse { response in

            XCTAssertTrue(Thread.isMainThread)

            XCTAssertNotNil(response.rateLimit)
            XCTAssertEqual(response.rateLimit?.limit, 15)
            XCTAssertEqual(response.rateLimit?.remaining, 1)
            XCTAssertEqual(response.rateLimit?.reset, 1_647_099_944)

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
        }.streamResponse(queue: .global(qos: .default)) { _ in
            XCTAssertFalse(Thread.isMainThread)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 100)
        XCTAssertEqual(count, 4)
    }

    func testInvalidStatusCode() throws {
        let mockTask = MockTwitterAPISessionTask(
            taskIdentifier: 2,
            currentRequest: nil,
            originalRequest: nil,
            httpResponse: HTTPURLResponse(
                url: URL(string: "https://example.com")!,
                statusCode: 400,
                httpVersion: "1.1",
                headerFields: [
                    "x-rate-limit-limit": "15",
                    "x-rate-limit-remaining": "1",
                    "x-rate-limit-reset": "1647099944",
                ]
            )
        )

        let task = TwitterAPISessionDelegatedStreamTask(task: mockTask)

        DispatchQueue.main.async {

            task.append(
                chunk: Data(
                    "{\"detail\":\"Authenticating with OAuth 1.0a User Context is forbidden for this endpoint.  Supported authentication types are [OAuth 2.0 Application-Only].\",\"title\":\"Unsupported Authentication\",\"status\":403,\"type\":\"https://api.twitter.com/2/problems/unsupported-authentication\"}"
                        .utf8))
            task.complete(error: nil)
        }

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 2

        var count = 0
        task.streamResponse { response in

            XCTAssertTrue(Thread.isMainThread)

            XCTAssertNotNil(response.rateLimit)
            XCTAssertEqual(response.rateLimit?.limit, 15)
            XCTAssertEqual(response.rateLimit?.remaining, 1)
            XCTAssertEqual(response.rateLimit?.reset, 1_647_099_944)

            switch count {
            case 0:
                XCTAssertTrue(response.error!.isResponseFailed)
            default:
                XCTFail()
            }

            count += 1
            exp.fulfill()
        }.streamResponse(queue: .global(qos: .default)) { response in
            XCTAssertFalse(Thread.isMainThread)
            XCTAssertTrue(response.error!.isResponseFailed)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 100)
        XCTAssertEqual(count, 1)
    }

    func testNilResponse() throws {

        let mockTask = MockTwitterAPISessionTask(
            taskIdentifier: 1,
            currentRequest: nil,
            originalRequest: nil,
            httpResponse: nil
        )

        let task = TwitterAPISessionDelegatedStreamTask(task: mockTask)

        DispatchQueue.main.async {
            task.append(chunk: Data("aaaa\r\nbbbb".utf8))
        }

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 2

        var count = 0
        task.streamResponse { response in

            XCTAssertTrue(Thread.isMainThread)

            switch count {
            case 0:
                XCTAssertTrue(response.isError)
                XCTAssertTrue(response.error!.isResponseFailed)
            default:
                XCTFail()
            }

            count += 1
            exp.fulfill()
        }.streamResponse(queue: .global(qos: .default)) { _ in
            XCTAssertFalse(Thread.isMainThread)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)
        XCTAssertEqual(count, 1)

    }

    func testError() throws {

        let mockTask = MockTwitterAPISessionTask(
            taskIdentifier: 1,
            currentRequest: nil,
            originalRequest: nil,
            httpResponse: nil
        )

        let task = TwitterAPISessionDelegatedStreamTask(task: mockTask)

        DispatchQueue.main.async {
            task.complete(error: URLError(.notConnectedToInternet))
        }

        let exp = expectation(description: "")
        exp.expectedFulfillmentCount = 2

        var count = 0
        task.streamResponse { response in

            XCTAssertTrue(Thread.isMainThread)

            XCTAssertNil(response.rateLimit)

            switch count {
            case 0:
                XCTAssertTrue(response.isError)

            default:
                XCTFail()
            }

            count += 1
            exp.fulfill()
        }.streamResponse(queue: .global(qos: .default)) { response in
            XCTAssertFalse(Thread.isMainThread)
            XCTAssertTrue(response.isError)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 100)
        XCTAssertEqual(count, 1)
    }
}
