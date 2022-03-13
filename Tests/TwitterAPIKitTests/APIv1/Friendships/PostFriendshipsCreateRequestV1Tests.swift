import TwitterAPIKit
import XCTest

class PostFriendshipsCreateRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostFriendshipsCreateRequestV1(
            user: .userID("uid"),
            follow: true
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/friendships/create.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_id": "uid",
                "follow": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostFriendshipsCreateRequestV1(
            user: .screenName("s")
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "screen_name": "s"
            ]
        )
    }
}
