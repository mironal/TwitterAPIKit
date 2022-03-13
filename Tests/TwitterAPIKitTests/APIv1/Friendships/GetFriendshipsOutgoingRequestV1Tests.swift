import TwitterAPIKit
import XCTest

class GetFriendshipsOutgoingRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetFriendshipsOutgoingRequestV1(
            cursor: "_c_",
            stringifyIDs: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/friendships/outgoing")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "cursor": "_c_",
                "stringify_ids": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetFriendshipsOutgoingRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
