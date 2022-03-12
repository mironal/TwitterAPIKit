import TwitterAPIKit
import XCTest

class PostFriendshipsUpdateRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostFriendshipsUpdateRequestV1(
            user: .userID("uid"),
            device: true,
            retweets: true
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/friendships/update.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_id": "uid",
                "device": true,
                "retweets": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostFriendshipsUpdateRequestV1(
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
