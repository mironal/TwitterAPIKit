import TwitterAPIKit
import XCTest

class GetListRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetListRequestV2(
            id: "_id_",
            expansions: [.ownerID],
            listFields: [.ownerID, .description],
            userFields: [.username]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/lists/_id_")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "owner_id",
                "list.fields": "description,owner_id",
                "user.fields": "username",
            ])
    }

    func testDefaultArg() throws {
        let req = GetListRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(req.parameters, [:])
    }
}
