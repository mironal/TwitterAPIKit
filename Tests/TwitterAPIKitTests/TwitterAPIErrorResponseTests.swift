import TwitterAPIKit
import XCTest

class TwitterAPIErrorResponseTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testTwitterAPIErrorResponseV1() throws {

        XCTContext.runActivity(named: "") { _ in

            let v1 = TwitterAPIErrorResponseV1(message: "_message_", code: 100, errors: [])
            XCTAssertEqual(v1.message, "_message_")
            XCTAssertEqual(v1.code, 100)
            XCTAssertEqual(v1.errors, [TwitterAPIErrorResponseV1]())
            XCTAssertTrue(v1.contains(code: 100))
            XCTAssertFalse(v1.contains(code: 1))
        }

        XCTContext.runActivity(named: "from obj") { _ in

            let obj: [String: Any] = [
                "errors": [
                    [
                        "message": "message1",
                        "code": 1,
                    ],
                    [
                        "message": "message2",
                        "code": 2,
                    ],
                ]

            ]

            let v1 = TwitterAPIErrorResponseV1(obj: obj)!
            XCTAssertEqual(v1.message, "message1")
            XCTAssertEqual(v1.code, 1)
            XCTAssertEqual(
                v1.errors,
                [
                    .init(message: "message1", code: 1, errors: []),
                    .init(message: "message2", code: 2, errors: []),
                ])
            XCTAssertTrue(v1.contains(code: 1))
            XCTAssertFalse(v1.contains(code: 100))

            XCTAssertEqual(
                v1,
                .init(
                    message: "message1", code: 1,
                    errors: [
                        .init(message: "message1", code: 1, errors: []),
                        .init(message: "message2", code: 2, errors: []),
                    ]))
        }

        XCTContext.runActivity(named: "Invalid") { _ in
            XCTAssertNil(TwitterAPIErrorResponseV1(obj: [:]))
        }
    }

    func testTwitterAPIErrorResponseV2() throws {

        XCTContext.runActivity(named: "") { _ in

            let v2 = TwitterAPIErrorResponseV2(title: "t", detail: "d", type: "ty", errors: [])
            XCTAssertEqual(v2.title, "t")
            XCTAssertEqual(v2.detail, "d")
            XCTAssertEqual(v2.type, "ty")
            XCTAssertEqual(v2.errors, [])
        }

        XCTContext.runActivity(named: "from obj") { _ in
            let obj: [String: Any] = [
                "title": "_title_",
                "detail": "_detail_",
                "type": "_type_",
                "errors": [
                    ["message": "_message_", "parameters": ["param": ["b"]]]

                ],
            ]
            let v2 = TwitterAPIErrorResponseV2(obj: obj)!
            XCTAssertEqual(v2.title, "_title_")
            XCTAssertEqual(v2.detail, "_detail_")
            XCTAssertEqual(v2.type, "_type_")
            XCTAssertEqual(v2.errors.first?.message, "_message_")
            XCTAssertEqual(v2.errors.first?.parameters["param"], ["b"])

            XCTAssertEqual(
                v2,
                TwitterAPIErrorResponseV2(
                    title: "_title_", detail: "_detail_", type: "_type_",
                    errors: [.init(message: "_message_", parameters: ["param": ["b"]])]))
        }

        XCTContext.runActivity(named: "Invalid") { _ in
            XCTAssertNil(TwitterAPIErrorResponseV2(obj: [:]))
        }
    }

    func testTwitterAPIErrorResponse() throws {

        try XCTContext.runActivity(named: "V1") { _ in
            let obj: [String: Any] = [
                "errors": [
                    [
                        "message": "message1",
                        "code": 1,
                    ],
                    [
                        "message": "message2",
                        "code": 2,
                    ],
                ]
            ]

            let data = try JSONSerialization.data(withJSONObject: obj, options: [])
            let error = TwitterAPIErrorResponse(data: data)

            XCTAssertTrue(error.isV1)
            XCTAssertNotNil(error.v1)

            XCTAssertFalse(error.isV2)
            XCTAssertNil(error.v2)

            XCTAssertFalse(error.isUnknown)
            XCTAssertNil(error.unknownData)

            XCTAssertEqual(error.message, "message1")
            XCTAssertEqual(error.code, 1)
        }

        try XCTContext.runActivity(named: "v2") { _ in
            let obj: [String: Any] = [
                "title": "_title_",
                "detail": "_detail_",
                "type": "_type_",
                "errors": [
                    ["message": "_message_", "parameters": ["param": ["b"]]]

                ],
            ]
            let data = try JSONSerialization.data(withJSONObject: obj, options: [])
            let error = TwitterAPIErrorResponse(data: data)

            XCTAssertFalse(error.isV1)
            XCTAssertNil(error.v1)

            XCTAssertTrue(error.isV2)
            XCTAssertNotNil(error.v2)

            XCTAssertFalse(error.isUnknown)
            XCTAssertNil(error.unknownData)

            XCTAssertEqual(error.message, "_detail_")
            XCTAssertNil(error.code)
        }

        XCTContext.runActivity(named: "unknown") { _ in

            XCTContext.runActivity(named: "empty") { _ in
                let error = TwitterAPIErrorResponse(data: Data())
                XCTAssertEqual(error, .unknown(Data()))
                XCTAssertTrue(error.isUnknown)
                XCTAssertEqual(error.message, "")
                XCTAssertNil(error.code)
            }

            XCTContext.runActivity(named: "invalid") { _ in
                let data = "{}".data(using: .utf8)!
                let error = TwitterAPIErrorResponse(data: data)
                XCTAssertEqual(error, .unknown(data))
                XCTAssertTrue(error.isUnknown)
                XCTAssertEqual(error.unknownData, data)
                XCTAssertEqual(error.message, "{}")
            }
        }
    }
}
