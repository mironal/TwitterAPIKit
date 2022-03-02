import XCTest

@testable import TwitterAPIKit

class TwitterAPIRequestTests: XCTestCase {

    private struct MockTwitterAPIRequest: TwitterAPIRequest {
        var method: HTTPMethod = .get
        var path: String = "/mock"
        var parameters: [String: Any]
        var baseURLType: TwitterBaseURLType = .api
        var bodyContentType: BodyContentType = .wwwFormUrlEncoded
    }

    private struct MockTwitterAPIQueryAndBodyRequest: TwitterAPIRequest {
        var method: HTTPMethod = .get
        var path: String = "/mock"
        var queryParameters: [String: Any]
        var bodyParameters: [String: Any]
        var baseURLType: TwitterBaseURLType = .api
        var bodyContentType: BodyContentType = .wwwFormUrlEncoded
    }

    private let env = TwitterAPIEnvironment(
        apiURL: .init(string: "https://api.example.com")!,
        uploadURL: .init(string: "https://upload.example.com")!
    )

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testRequestURL() throws {

        XCTContext.runActivity(named: "api") { _ in
            let req = MockTwitterAPIRequest(parameters: ["key": "value"], baseURLType: .api)
            XCTAssertEqual(req.requestURL(for: env).absoluteString, "https://api.example.com/mock")
        }

        XCTContext.runActivity(named: "upload") { _ in
            let req = MockTwitterAPIRequest(parameters: ["key": "value"], baseURLType: .upload)
            XCTAssertEqual(req.requestURL(for: env).absoluteString, "https://upload.example.com/mock")
        }
    }

    func testParameterForOAuth() throws {

        XCTContext.runActivity(named: "wwwFormUrlEncoded") { _ in
            let req = MockTwitterAPIRequest(parameters: ["key": "value"], bodyContentType: .wwwFormUrlEncoded)
            XCTAssertEqual(req.parameterForOAuth as! [String: String], ["key": "value"])
        }

        XCTContext.runActivity(named: "json") { _ in
            let req = MockTwitterAPIRequest(parameters: ["key": "value"], bodyContentType: .json)
            XCTAssertEqual(req.parameterForOAuth as! [String: String], [:])
        }

        XCTContext.runActivity(named: "multipartFormData") { _ in
            let req = MockTwitterAPIRequest(parameters: ["key": "value"], bodyContentType: .multipartFormData)
            XCTAssertEqual(req.parameterForOAuth as! [String: String], [:])
        }
    }

    func testParameterByMethods() throws {

        // 🥓 = F0 9F A5 93

        try XCTContext.runActivity(named: "GET") { _ in
            let req = MockTwitterAPIRequest(
                method: .get,
                parameters: ["key": "value,🥓"]
            )

            XCTAssertEqual(req.queryParameters as! [String: String], ["key": "value,🥓"])
            XCTAssertEqual(req.bodyParameters as! [String: String], [:])

            let urlReq = try req.buildRequest(environment: env)

            XCTAssertEqual(urlReq.httpMethod, "GET")
            XCTAssertEqual(urlReq.url?.query, "key=value%2C%F0%9F%A5%93")
            XCTAssertNil(urlReq.httpBody)
        }

        try XCTContext.runActivity(named: "POST") { _ in
            let req = MockTwitterAPIRequest(
                method: .post,
                parameters: ["key": "value,🥓"]
            )

            XCTAssertEqual(req.queryParameters as! [String: String], [:])
            XCTAssertEqual(req.bodyParameters as! [String: String], ["key": "value,🥓"])

            let urlReq = try req.buildRequest(environment: env)

            XCTAssertEqual(urlReq.httpMethod, "POST")
            XCTAssertNil(urlReq.url?.query)
            XCTAssertEqual(String(data: urlReq.httpBody!, encoding: .utf8)!, "key=value%2C%F0%9F%A5%93")
        }

        try XCTContext.runActivity(named: "PUT") { _ in
            let req = MockTwitterAPIRequest(
                method: .put,
                parameters: ["key": "value,🥓"]
            )

            XCTAssertEqual(req.queryParameters as! [String: String], [:])
            XCTAssertEqual(req.bodyParameters as! [String: String], ["key": "value,🥓"])

            let urlReq = try req.buildRequest(environment: env)

            XCTAssertEqual(urlReq.httpMethod, "PUT")
            XCTAssertNil(urlReq.url?.query)
            XCTAssertEqual(String(data: urlReq.httpBody!, encoding: .utf8)!, "key=value%2C%F0%9F%A5%93")
        }

        try XCTContext.runActivity(named: "DELETE") { _ in
            let req = MockTwitterAPIRequest(
                method: .delete,
                parameters: ["key": "value,🥓"]
            )

            XCTAssertEqual(req.queryParameters as! [String: String], ["key": "value,🥓"])
            XCTAssertEqual(req.bodyParameters as! [String: String], [:])

            let urlReq = try req.buildRequest(environment: env)

            XCTAssertEqual(urlReq.httpMethod, "DELETE")
            XCTAssertEqual(urlReq.url?.query, "key=value%2C%F0%9F%A5%93")
            XCTAssertNil(urlReq.httpBody)
        }
    }

    func testURLQueryPercentEncode() throws {

        let req = MockTwitterAPIRequest(
            method: .get,
            parameters: [
                "☃": "1970-01-01T00:01:00Z",
                "key": "v a l u e",
                "キー": "値",
            ]
        )

        let urlReq = try req.buildRequest(environment: env)

        XCTAssertEqual(
            urlReq.url?.query, #"key=v%20a%20l%20u%20e&%E2%98%83=1970-01-01T00%3A01%3A00Z&%E3%82%AD%E3%83%BC=%E5%80%A4"#
        )
    }

    func testBodyAndQueryParameter() throws {
        let req = MockTwitterAPIQueryAndBodyRequest(
            method: .post,
            queryParameters: ["key": "value,🥓"],
            bodyParameters: ["body": "あ"]
        )

        XCTAssertEqual(req.parameters as! [String: String], [:])
        XCTAssertEqual(req.queryParameters as! [String: String], ["key": "value,🥓"])
        XCTAssertEqual(req.bodyParameters as! [String: String], ["body": "あ"])

        let urlReq = try req.buildRequest(environment: env)

        XCTAssertEqual(urlReq.httpMethod, "POST")
        XCTAssertEqual(urlReq.url?.query, "key=value%2C%F0%9F%A5%93")
        XCTAssertEqual(String(data: urlReq.httpBody!, encoding: .utf8)!, "body=%E3%81%82")
    }

    func testBodyContentType() throws {

        try XCTContext.runActivity(named: "wwwFormUrlEncoded") { _ in

            let req = try MockTwitterAPIRequest(
                method: .post,
                parameters: ["key": "value,🥓"],
                bodyContentType: .wwwFormUrlEncoded
            ).buildRequest(environment: env)

            let body = String(data: req.httpBody!, encoding: .utf8)

            XCTAssertEqual(body, "key=value%2C%F0%9F%A5%93")
        }

        try XCTContext.runActivity(named: "multipartFormData") { _ in

            let req = try MockTwitterAPIRequest(
                method: .post,
                parameters: [
                    "a-value": MultipartFormDataPart.value(name: "a", value: "value"),
                    "b-data": MultipartFormDataPart.data(
                        name: "b", value: Data("ab".utf8), filename: "hoge.txt", mimeType: "plain/text"),
                ],
                bodyContentType: .multipartFormData
            ).buildRequest(environment: env)

            XCTAssertTrue(
                req.allHTTPHeaderFields!["Content-Type"]!.hasPrefix("multipart/form-data; boundary=TwitterAPIKit-"))

            let boundary = req.allHTTPHeaderFields!["Content-Type"]!.replacingOccurrences(
                of: "multipart/form-data; boundary=", with: "")

            let body = String(data: req.httpBody!, encoding: .utf8)!

            let expect =
                "--\(boundary)\r\nContent-Disposition: form-data; name=\"a\"\r\n\r\nvalue\r\n--\(boundary)\r\nContent-Disposition: form-data; name=\"b\"; filename=\"hoge.txt\"\r\nContent-Type: plain/text\r\n\r\nab\r\n--\(boundary)--\r\n"

            XCTAssertEqual(body, expect)

            try XCTContext.runActivity(named: "Invalid parameter") { _ in

                XCTAssertThrowsError(
                    try MockTwitterAPIRequest(
                        method: .post,
                        parameters: ["key": "value,🥓"],
                        bodyContentType: .multipartFormData
                    ).buildRequest(environment: env)
                ) { error in
                    XCTAssertTrue(error is TwitterAPIKitError)
                }
            }
        }

        try XCTContext.runActivity(named: "json") { _ in
            let req = try MockTwitterAPIRequest(
                method: .post,
                parameters: ["key": "value,🥓"],
                bodyContentType: .json
            ).buildRequest(environment: env)

            let body = try JSONSerialization.jsonObject(with: req.httpBody!, options: [])

            XCTAssertEqual(body as! [String: String], ["key": "value,🥓"])

            try XCTContext.runActivity(
                named: "Invalid",
                block: { _ in
                    XCTAssertThrowsError(
                        try MockTwitterAPIRequest(
                            method: .post,
                            parameters: ["key": Data()],
                            bodyContentType: .json
                        ).buildRequest(environment: env)
                    ) { error in
                        if case .jsonSerializationFailed(obj: _) = (error as! TwitterAPIKitError).requestFailureReason {

                        } else {
                            XCTFail()
                        }
                    }
                }
            )

            try XCTContext.runActivity(
                named: "Invalid value",
                block: { _ in
                    XCTAssertThrowsError(
                        try MockTwitterAPIRequest(
                            method: .post,
                            parameters: [
                                String(bytes: [0xD8, 0x00] as [UInt8], encoding: String.Encoding.utf16BigEndian)!:
                                    String(bytes: [0xD8, 0x00] as [UInt8], encoding: String.Encoding.utf16BigEndian)!
                            ],
                            bodyContentType: .json
                        ).buildRequest(environment: env)
                    ) { error in

                        if case .jsonSerializationFailed(obj: _) = (error as! TwitterAPIKitError).requestFailureReason {

                        } else {
                            XCTFail()
                        }
                    }
                }
            )

        }
    }
}
