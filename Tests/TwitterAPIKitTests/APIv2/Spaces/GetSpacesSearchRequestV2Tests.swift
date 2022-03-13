import TwitterAPIKit
import XCTest

class GetSpacesSearchRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetSpacesSearchRequestV2(
            query: "_q_",
            expansions: [.creatorID],
            spaceFields: [.invitedUserIDs],
            state: .scheduled,
            topicFields: [.name],
            userFields: [.username]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/spaces/search")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "query": "_q_",
                "expansions": "creator_id",
                "space.fields": "invited_user_ids",
                "state": "scheduled",
                "topic.fields": "name",
                "user.fields": "username",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetSpacesSearchRequestV2(
            query: "あ"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "query": "あ"
            ]
        )
    }
}
