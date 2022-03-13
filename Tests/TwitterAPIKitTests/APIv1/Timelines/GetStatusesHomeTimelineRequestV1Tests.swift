import TwitterAPIKit
import XCTest

class GetStatusesHomeTimelineRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetStatusesHomeTimelineRequestV1(
            count: 11,
            maxID: "_m_",
            sinceID: "_s_",
            trimUser: true,
            excludeReplies: true,
            includeEntities: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/statuses/home_timeline.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "count": 11,
                "max_id": "_m_",
                "since_id": "_s_",
                "trim_user": true,
                "exclude_replies": true,
                "include_entities": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetStatusesHomeTimelineRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
