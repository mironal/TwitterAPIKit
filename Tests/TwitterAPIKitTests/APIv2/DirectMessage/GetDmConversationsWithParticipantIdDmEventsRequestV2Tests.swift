import TwitterAPIKit
import XCTest

class GetDmConversationsWithParticipantIdDmEventsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetDmConversationsWithParticipantIdDmEventsRequestV2(
            participantID: "_p_id",
            maxResults: 12,
            paginationToken: "_p_",
            eventTypes: [.participantsLeave],
            dmEventFields: [.eventType],
            expansions: [.attachmentsMediaKeys],
            mediaFields: [],
            userFields: [],
            tweetFields: []
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/dm_conversations/with/_p_id/dm_events")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "max_results": 12,
                "pagination_token": "_p_",
                "event_types": "ParticipantsLeave",
                "dm_event.fields": "event_type",
                "expansions": "attachments.media_keys",
                "media.fields": "",
                "user.fields": "",
                "tweet.fields": "",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetDmConversationsWithParticipantIdDmEventsRequestV2(
            participantID: "p"
        )

        XCTAssertEqual(req.path, "/2/dm_conversations/with/p/dm_events")
        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
