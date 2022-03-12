import TwitterAPIKit
import XCTest

class GetMutesUsersListRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetMutesUsersListRequestV1(
            cursor: "_c_",
            includeEntities: true,
            skipStatus: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/mutes/users/list.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "cursor": "_c_",
                "include_entities": true,
                "skip_status": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetMutesUsersListRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
