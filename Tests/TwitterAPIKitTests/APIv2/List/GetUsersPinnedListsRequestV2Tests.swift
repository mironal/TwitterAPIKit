import TwitterAPIKit
import XCTest

class GetUsersPinnedListsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersPinnedListsRequestV2(
            id: "_id_",
            expansions: [.ownerID],
            listFields: [.id],
            userFields: [.username]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_id_/pinned_lists")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "owner_id",
                "list.fields": "id",
                "user.fields": "username",
            ])
    }

    func testDefaultArg() throws {
        let req = GetUsersPinnedListsRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(req.parameters, [:])
    }
}
