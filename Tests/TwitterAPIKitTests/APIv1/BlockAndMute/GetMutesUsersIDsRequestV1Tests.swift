import TwitterAPIKit
import XCTest

class GetMutesUsersIDsRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetMutesUsersIDsRequestV1(
            stringifyIDs: true,
            cursor: "_c_"
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/mutes/users/ids.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "stringify_ids": true,
                "cursor": "_c_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetMutesUsersIDsRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
