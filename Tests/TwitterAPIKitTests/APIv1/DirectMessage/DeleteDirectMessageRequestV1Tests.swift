import TwitterAPIKit
import XCTest

class DeleteDirectMessageRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = DeleteDirectMessageRequestV1(id: "15")
        XCTAssertEqual(req.method, .delete)
        XCTAssertEqual(req.path, "/1.1/direct_messages/events/destroy.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(req.parameters, ["id": "15"])
        AssertEqualAnyDict(req.queryParameters, ["id": "15"])
    }
}
