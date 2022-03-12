import TwitterAPIKit
import XCTest

class GetUsersListMembershipsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersListMembershipsRequestV2(
            id: "_id_",
            expansions: [.ownerID],
            listFields: [.followerCount],
            maxResults: 10,
            paginationToken: "t",
            userFields: [.protected]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_id_/list_memberships")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "owner_id",
                "list.fields": "follower_count",
                "max_results": 10,
                "pagination_token": "t",
                "user.fields": "protected",
            ])
    }

    func testDefaultArg() throws {
        let req = GetUsersListMembershipsRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(req.parameters, [:])
    }
}
