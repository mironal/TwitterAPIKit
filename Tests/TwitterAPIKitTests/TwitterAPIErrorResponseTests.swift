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
        }
    }
}
