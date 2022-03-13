import TwitterAPIKit
import XCTest

class GetStatusesUserTimelineRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetStatusesUserTimelineRequestV1(
            user: .userID("uid"),
            count: 12,
            maxID: "_m_",
            sinceID: "_s_",
            trimUser: true,
            includeRTs: true,
            excludeReplies: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/statuses/user_timeline.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "user_id": "uid",
                "count": 12,
                "max_id": "_m_",
                "since_id": "_s_",
                "trim_user": true,
                "include_rts": true,
                "exclude_replies": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetStatusesUserTimelineRequestV1(
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
