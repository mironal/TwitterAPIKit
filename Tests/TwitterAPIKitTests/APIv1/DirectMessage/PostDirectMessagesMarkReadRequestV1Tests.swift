import TwitterAPIKit
import XCTest

class PostDirectMessagesMarkReadRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostDirectMessagesMarkReadRequestV1(lastReadEventID: "ev_id", recipientID: "r_id")

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.path, "/1.1/direct_messages/mark_read.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "last_read_event_id": "ev_id",
                "recipient_id": "r_id",
            ])
    }
}
