import TwitterAPIKit
import XCTest

class GetTweetsCountsRecentRequestV2Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetTweetsCountsRecentRequestV2(
            query: "q",
            endTime: Date(timeIntervalSince1970: 0),
            granularity: .hour,
            sinceID: "s",
            startTime: Date(timeIntervalSince1970: 120),
            untilID: "u"
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.path, "/2/tweets/counts/recent")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "query": "q",
                "end_time": "1970-01-01T00:00:00Z",
                "granularity": "hour",
                "since_id": "s",
                "start_time": "1970-01-01T00:02:00Z",
                "until_id": "u",
            ])
    }
}
