import TwitterAPIKit
import XCTest

class GetRetweetsOfMeRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetRetweetsOfMeRequestV1(
            count: 10,
            sinceID: "_s_",
            maxID: "_m_",
            trimUser: true,
            includeEntities: true,
            includeUserEntities: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/statuses/retweets_of_me.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "count": 10,
                "since_id": "_s_",
                "max_id": "_m_",
                "trim_user": true,
                "include_entities": true,
                "include_user_entities": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetRetweetsOfMeRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
