import TwitterAPIKit
import XCTest

class GetCollectionsListRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetCollectionsListRequestV1(
            user: .userID("uid"),
            count: 14,
            cursor: "_c_",
            tweetID: "_t_"
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/collections/list.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_id": "uid",
                "count": 14,
                "cursor": "_c_",
                "tweet_id": "_t_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetCollectionsListRequestV1(
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
