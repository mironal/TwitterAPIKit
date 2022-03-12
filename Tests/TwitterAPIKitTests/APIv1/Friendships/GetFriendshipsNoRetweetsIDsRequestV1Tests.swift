import TwitterAPIKit
import XCTest

class GetFriendshipsNoRetweetsIDsRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetFriendshipsNoRetweetsIDsRequestV1(
            stringifyIDs: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/friendships/no_retweets/ids.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "stringify_ids": true
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetFriendshipsNoRetweetsIDsRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
