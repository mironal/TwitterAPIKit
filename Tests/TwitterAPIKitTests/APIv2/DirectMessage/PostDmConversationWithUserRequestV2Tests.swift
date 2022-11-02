import TwitterAPIKit
import XCTest

class PostDmConversationWithUserRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostDmConversationWithUserRequestV2(
            participantID: "_p_",
            attachments: ["10"],
            text: "_t_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/dm_conversations/with/_p_/messages")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "attachments": [["media_id": "10"]],
                "text": "_t_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostDmConversationWithUserRequestV2(
            participantID: "_p_id"
        )

        XCTAssertEqual(req.path, "/2/dm_conversations/with/_p_id/messages")
        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
