import TwitterAPIKit
import XCTest

class GetStatusesMentionsTimelineRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetStatusesMentionsTimelineRequestV1(
            count: 100,
            maxID: "_m_",
            sinceID: "_s_",
            trimUser: true,
            includeEntities: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/statuses/mentions_timeline.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "count": 100,
                "max_id": "_m_",
                "since_id": "_s_",
                "trim_user": true,
                "include_entities": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetStatusesMentionsTimelineRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
