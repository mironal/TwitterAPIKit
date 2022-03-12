import TwitterAPIKit
import XCTest

class GetSpacesByCreatorIDsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetSpacesByCreatorIDsRequestV2(
            userIDs: ["a", "b"],
            expansions: [.invitedUserIDs],
            spaceFields: [.isTicketed],
            topicFields: [.name],
            userFields: [.verified]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/spaces/by/creator_ids")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_ids": "a,b",
                "expansions": "invited_user_ids",
                "space.fields": "is_ticketed",
                "topic.fields": "name",
                "user.fields": "verified",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetSpacesByCreatorIDsRequestV2(
            userIDs: ["a", "b", "c"]
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "user_ids": "a,b,c"
            ]
        )
    }
}
