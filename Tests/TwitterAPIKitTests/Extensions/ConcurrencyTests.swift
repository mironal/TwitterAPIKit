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
                task.append(chunk: Data(":\"value\"}".utf8))

                mockTask.httpResponse = .init(
                    url: URL(string: "http://example.com")!, statusCode: 200, httpVersion: "1.1", headerFields: [:])

                task.complete(error: nil)
            }

            async let response = task.responseData
            async let responseObj = task.responseObject
            async let responseDecodable = task.responseDecodable(type: DecodableObj.self)
            async let aResponse = task.specialized { _ in "a" }.responseObject

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

            do {
                let a = await aResponse.success
                XCTAssertEqual(a, "a")
            }
        }

        func testCancel() async throws {
            let mockTask = MockTwitterAPISessionTask(taskIdentifier: 1)

            let task = TwitterAPISessionDelegatedJSONTask(
                task: mockTask
            )

            DispatchQueue.global(qos: .default).async {
                task.append(chunk: Data("{\"key\"".utf8))
                task.append(chunk: Data(":\"value\"}".utf8))

                // emurate cancel
                task.cancel()
                task.complete(error: URLError(.cancelled))
            }

            async let response = task.responseData
            async let responseObj = task.responseObject
            async let responseDecodable = task.responseDecodable(type: DecodableObj.self)
            async let aResponse = task.specialized { _ in "a" }.responseObject

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

            do {
                let error = await aResponse.error
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
                async let r3 = task.specialized { _ in () }.responseObject
                return await [r0, r1, r2, r3]
            }

            DispatchQueue.global(qos: .default).async {
                task.append(chunk: Data("{\"key\"".utf8))
                task.append(chunk: Data(":\"value\"}".utf8))

                asyncTask.cancel()
                task.complete(error: URLError(.cancelled))
            }

            let rs = await asyncTask.value
            XCTAssertTrue(mockTask.cancelled)
            XCTAssertTrue(asyncTask.isCancelled)
            XCTAssertEqual(rs.count, 4)
            for r in rs {
                XCTAssertTrue(r.error!.isCancelled)
            }
        }

        func testStream() async throws {
            let mockTask = MockTwitterAPISessionTask(
                taskIdentifier: 1,
                currentRequest: nil,
                originalRequest: nil,
                httpResponse: .init(
                    url: URL(string: "http://example.com")!, statusCode: 200, httpVersion: "1.1", headerFields: [:]
                )
            )

            let task = TwitterAPISessionDelegatedStreamTask(task: mockTask)

            let stream = task.streamResponse(queue: .main)
            DispatchQueue.global(qos: .default).async {
                task.append(chunk: Data("aaaa\r\nbbbb".utf8))
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
            let stream = task.streamResponse(queue: .main)
            let asyncTask = Task {
                for await resp in stream {
                    XCTFail(resp.prettyString)
                }
            }

            DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + .milliseconds(1)) {
                asyncTask.cancel()
                task.append(chunk: Data("aaaa\r\nbbbb".utf8))
            }

            await asyncTask.value

            XCTAssertTrue(asyncTask.isCancelled)
            XCTAssertTrue(mockTask.cancelled)
        }

        func testStreamError() async throws {

            let mockTask = MockTwitterAPISessionTask(
                taskIdentifier: 1,
                currentRequest: nil,
                originalRequest: nil,
                httpResponse: .init(
                    url: URL(string: "http://example.com")!, statusCode: 200, httpVersion: "1.1", headerFields: [:]
                )
            )

            let task = TwitterAPISessionDelegatedStreamTask(task: mockTask)
            let stream = task.streamResponse(queue: .main).map({ resp in resp.map { String(data: $0, encoding: .utf8)! }
            })
            let asyncTask = Task {
                var count = 0
                for await resp in stream {

                    switch count {
                    case 0:
                        XCTAssertEqual(resp.success, "aaaa")
                        XCTAssertFalse(resp.isError)
                    case 1:
                        XCTAssertEqual(resp.success, "bbbb")
                        XCTAssertFalse(resp.isError)
                    case 2:
                        XCTAssertTrue(resp.isError)
                    default:
                        XCTFail()
                    }
                    count += 1
                }
            }

            DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + .milliseconds(1)) {
                task.append(chunk: Data("aaaa\r\nbbbb".utf8))
                task.complete(error: URLError(.badServerResponse))
                task.append(chunk: Data("ccc\r\n".utf8))
            }

            await asyncTask.value
        }
    }
#endif
