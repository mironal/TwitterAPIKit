import TwitterAPIKit
import XCTest

class PostDmConversationRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostDmConversationRequestV2(
            conversationType: .group,
            participantIDs: ["a", "b"],
            attachments: ["2", "3"],
            text: "_t_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/dm_conversations")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "conversation_type": "Group",
                "participant_ids": ["a", "b"],
                "message": [
                    "attachments": [["media_id": "2"], ["media_id": "3"]],
                    "text": "_t_",
                ],
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostDmConversationRequestV2(
            conversationType: .group,
            participantIDs: ["a", "b", "c"]
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "conversation_type": "Group",
                "participant_ids": ["a", "b", "c"],
                "message": [:],
            ]
        )
    }
}
