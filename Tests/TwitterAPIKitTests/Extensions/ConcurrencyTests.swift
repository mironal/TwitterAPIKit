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

            DispatchQueue.global(qos: .default).async {
                task.append(chunk: Data("{\"key\"".utf8))
                Thread.sleep(forTimeInterval: 0.01)
                task.append(chunk: Data(":\"value\"}".utf8))

                mockTask.httpResponse = .init(
                    url: URL(string: "http://example.com")!, statusCode: 200, httpVersion: "1.1", headerFields: [:])

                Thread.sleep(forTimeInterval: 0.01)
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

        func testCancel() async throws {
            let mockTask = MockTwitterAPISessionTask(taskIdentifier: 1)

            let task = TwitterAPISessionDelegatedJSONTask(
                task: mockTask
            )

            DispatchQueue.global(qos: .default).async {
                task.append(chunk: Data("{\"key\"".utf8))
                Thread.sleep(forTimeInterval: 0.01)
                task.append(chunk: Data(":\"value\"}".utf8))

                Thread.sleep(forTimeInterval: 0.01)
                // emurate cancel
                task.cancel()
                task.complete(error: URLError(.cancelled))
            }

            async let response = task.responseData
            async let responseObj = task.responseObject
            async let responseDecodable = task.responseDecodable(type: DecodableObj.self)

            do {
                let error = await response.error
                XCTAssertTrue(error!.isCancelled)
            }

            do {
                let error = await responseObj.error
                XCTAssertTrue(error!.isCancelled)
            }

            do {
                let error = await responseDecodable.error
                XCTAssertTrue(error!.isCancelled)
            }

            XCTAssertTrue(mockTask.cancelled)
        }

        func testTaskCancel() async throws {

            let mockTask = MockTwitterAPISessionTask(taskIdentifier: 1)

            let task = TwitterAPISessionDelegatedJSONTask(
                task: mockTask
            )

            let asyncTask = Task { () -> [TwitterAPIResponse<Void>] in
                async let r0 = task.responseData.map { _ in () }
                async let r1 = task.responseObject.map { _ in () }
                async let r2 = task.responseDecodable(type: DecodableObj.self).map { _ in () }
                return await [r0, r1, r2]
            }

            DispatchQueue.global(qos: .default).async {
                task.append(chunk: Data("{\"key\"".utf8))
                Thread.sleep(forTimeInterval: 0.01)
                task.append(chunk: Data(":\"value\"}".utf8))

                Thread.sleep(forTimeInterval: 0.01)
                asyncTask.cancel()
                task.complete(error: URLError(.cancelled))
            }

            let rs = await asyncTask.value
            XCTAssertTrue(mockTask.cancelled)
            XCTAssertTrue(asyncTask.isCancelled)
            XCTAssertEqual(rs.count, 3)
            for r in rs {
                XCTAssertTrue(r.error!.isCancelled)
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

            let stream = task.streamResponse(queue: .main)
            DispatchQueue.global(qos: .default).async {
                task.append(chunk: Data("aaaa\r\nbbbb".utf8))
                Thread.sleep(forTimeInterval: 0.01)
                task.append(chunk: Data("🥓🥓\r\nあ".utf8))
            }

            var count = 0
            for await response in stream {

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
                if count == 4 {
                    break
                }
            }
            XCTAssertEqual(count, 4)
        }

        func testStreamCancel() async throws {

            let mockTask = MockTwitterAPISessionTask(
                taskIdentifier: 1,
                currentRequest: nil,
                originalRequest: nil,
                httpResponse: nil
            )

            let task = TwitterAPISessionDelegatedStreamTask(task: mockTask)
            let asyncTask = Task {
                for await resp in task.streamResponse(queue: .main) {
                    XCTAssertFalse(resp.isError)
                }
            }

            task.append(chunk: Data("aaaa\r\nbbbb".utf8))

            DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + .milliseconds(1)) {
                asyncTask.cancel()
            }

            await asyncTask.value
            XCTAssertTrue(mockTask.cancelled)
            XCTAssertTrue(asyncTask.isCancelled)
        }
    }
#endif
