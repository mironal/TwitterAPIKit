import XCTest

@testable import TwitterAPIKit

#if compiler(>=5.5.2) && canImport(_Concurrency)

    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    class ConcurrencyTests: XCTestCase {

        override func setUpWithError() throws {
        }

        override func tearDownWithError() throws {
        }

        func test() async throws {
            let mockTask = MockTwitterAPISessionTask(taskIdentifier: 1)

            let task = TwitterAPISessionDelegatedJSONTask(
                task: mockTask
            )

            DispatchQueue.global(qos: .background).async {
                task.append(chunk: Data("{\"key\"".utf8))
                Thread.sleep(forTimeInterval: 0.1)
                task.append(chunk: Data(":\"value\"}".utf8))

                mockTask.httpResponse = .init(
                    url: URL(string: "http://example.com")!, statusCode: 200, httpVersion: "1.1", headerFields: [:])

                task.complete(error: nil)
            }

            async let response = task.responseData
            async let responseObj = task.responseObject
            async let responseDecodable = task.responseDecodable(type: DecodableObj.self)

            do {
                let data = await response.success
                XCTAssertEqual(data, Data("{\"key\":\"value\"}".utf8))
            }

            do {
                let obj = await responseObj.success
                AssertEqualAnyDict(obj as! [String: Any], ["key": "value"])
            }

            do {
                let obj = await responseDecodable.success
                XCTAssertEqual(obj, .init(key: "value"))
            }

        }

        func testStream() async throws {
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

            var count = 0
            for await response in task.streamResponse(queue: .main).prefix(4) {
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
            }
            XCTAssertEqual(count, 4)
        }
    }
#endif
