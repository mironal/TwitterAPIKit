import TwitterAPIKit
import XCTest

class PostDirectMessagesIndicateTypingRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostDirectMessagesIndicateTypingRequestV1(
            recipientID: "234"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.path, "/1.1/direct_messages/indicate_typing.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(req.parameters, ["recipient_id": "234"])
    }
}
