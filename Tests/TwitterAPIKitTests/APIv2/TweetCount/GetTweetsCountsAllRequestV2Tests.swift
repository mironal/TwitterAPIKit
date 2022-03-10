import TwitterAPIKit
import XCTest

class GetTweetsCountsAllRequestV2Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetTweetsCountsAllRequestV2(
            query: "a",
            endTime: Date(timeIntervalSince1970: 10),
            granularity: .minute,
            nextToken: "n",
            sinceID: "s",
            startTime: Date(timeIntervalSince1970: 5),
            untilID: "u"
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.path, "/2/tweets/counts/all")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "query": "a",
                "end_time": "1970-01-01T00:00:10Z",
                "granularity": "minute",
                "next_token": "n",
                "since_id": "s",
                "start_time": "1970-01-01T00:00:05Z",
                "until_id": "u",
            ])
    }
}
