import TwitterAPIKit
import XCTest

class GetFriendshipsShowRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetFriendshipsShowRequestV1(
            sourceUser: .userID("suid"),
            targetUser: .userID("tuid")
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/friendships/show.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "source_id": "suid",
                "target_id": "tuid",
            ]
        )
    }

    func testScreenName() throws {
        let req = GetFriendshipsShowRequestV1(
            sourceUser: .screenName("s"),
            targetUser: .screenName("t")
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "source_screen_name": "s",
                "target_screen_name": "t",
            ]
        )
    }
}
