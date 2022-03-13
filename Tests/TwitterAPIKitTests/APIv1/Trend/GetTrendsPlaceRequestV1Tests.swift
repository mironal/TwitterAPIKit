import TwitterAPIKit
import XCTest

class GetTrendsPlaceRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetTrendsPlaceRequestV1(
            woeid: "_w_",
            exclude: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/trends/place.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "woeid": "_w_",
                "exclude": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetTrendsPlaceRequestV1(
            woeid: "_w_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "woeid": "_w_"
            ]
        )
    }
}
