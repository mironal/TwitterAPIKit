import TwitterAPIKit
import XCTest

class GetRetweetsRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetRetweetsRequestV1(
            id: "_i_",
            count: 12,
            trimUser: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/statuses/retweets/_i_.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "count": 12,
                "trim_user": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetRetweetsRequestV1(
            id: "_i_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
