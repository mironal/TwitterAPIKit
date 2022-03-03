import TwitterAPIKit
import XCTest

class GetDirectMessageListRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetDirectMessageListRequestV1(
            count: 100,
            cursor: "cursor_str"
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.path, "/1.1/direct_messages/events/list.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "count": 100,
                "cursor": "cursor_str",
            ])
        XCTAssertTrue(req.bodyParameters.isEmpty)
    }

}
