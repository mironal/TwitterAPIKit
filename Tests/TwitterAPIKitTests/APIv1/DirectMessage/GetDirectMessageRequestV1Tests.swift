import TwitterAPIKit
import XCTest

class GetDirectMessageRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetDirectMessageRequestV1(id: "dm_id")

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.path, "/1.1/direct_messages/events/show.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(req.parameters, ["id": "dm_id"])
    }
}
