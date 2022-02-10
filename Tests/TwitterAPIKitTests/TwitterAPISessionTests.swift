import XCTest

@testable import TwitterAPIKit

private class GetTwitterReqeust: TwitterAPIRequest {
    var method: HTTPMethod { return .get }
    var path: String { return "/get.json" }
    var parameters: [String: Any] {
        return ["hoge": "😀"]  //= %F0%9F%98%80
    }
}

private class PostTwitterReqeust: TwitterAPIRequest {
    var method: HTTPMethod { return .post }
    var path: String { return "/post.json" }
    var parameters: [String: Any] {
        return ["hoge": "😀"]  //= %F0%9F%98%80
    }
}

class TwitterAPISessionTests: XCTestCase {

    lazy var session: TwitterAPISession =
        ({

            let config = URLSessionConfiguration.default
            config.protocolClasses = [MockURLProtocol.self]
            let urlSession = URLSession.init(configuration: config)

            return TwitterAPISession(
                auth: .oauth(consumerKey: "", consumerSecret: "", oauthToken: "", oauthTokenSecret: ""),
                session: urlSession,
                environment: .init(
                    apiURL: URL(string: "https://api.example.com")!,
                    uploadURL: URL(string: "https://upload.example.com")!)
            )
        })()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGET() throws {

        MockURLProtocol.requestAssert = { request in
            XCTAssertEqual(request.httpMethod, "GET")
            XCTAssertEqual(request.url?.absoluteString, "https://api.example.com/get.json?hoge=%F0%9F%98%80")
            XCTAssertNil(request.httpBody)
        }

        let exp = expectation(description: "")
        session.send(GetTwitterReqeust()) { _ in
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }

    func testPOST() throws {
        MockURLProtocol.requestAssert = { request in
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(request.url?.absoluteString, "https://api.example.com/post.json")
            XCTAssertNil(request.httpBody)
            let data = try! Data(reading: request.httpBodyStream!)
            let body = String(data: data, encoding: .utf8)!
            XCTAssertEqual(body, "hoge=%F0%9F%98%80")
        }

        let exp = expectation(description: "")
        session.send(PostTwitterReqeust()) { _ in
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
}

extension Data {
    init(reading input: InputStream) throws {
        self.init()
        input.open()
        defer {
            input.close()
        }

        let bufferSize = 1024
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        defer {
            buffer.deallocate()
        }
        while input.hasBytesAvailable {
            let read = input.read(buffer, maxLength: bufferSize)
            if read < 0 {
                //Stream error occured
                throw input.streamError!
            } else if read == 0 {
                //EOF
                break
            }
            self.append(buffer, count: read)
        }
    }
}
