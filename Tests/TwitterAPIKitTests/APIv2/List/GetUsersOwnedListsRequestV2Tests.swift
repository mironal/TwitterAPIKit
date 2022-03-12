import TwitterAPIKit
import XCTest

class GetUsersOwnedListsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersOwnedListsRequestV2(
            id: "_id_",
            expansions: [.ownerID],
            listFields: [.memberCount],
            maxResults: 11,
            paginationToken: "t",
            userFields: [.createdAt]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_id_/owned_lists")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "owner_id",
                "list.fields": "member_count",
                "max_results": 11,
                "pagination_token": "t",
                "user.fields": "created_at",

            ])
    }

    func testDefaultArg() throws {
        let req = GetUsersOwnedListsRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(req.parameters, [:])
    }
}
