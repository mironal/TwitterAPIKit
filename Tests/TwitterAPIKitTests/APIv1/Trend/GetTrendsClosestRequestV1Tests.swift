import TwitterAPIKit
import XCTest

class GetTrendsClosestRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetTrendsClosestRequestV1(
            location: TwitterCoordinateV1(lat: 37.7, long: -122.4)
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/trends/closest.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "lat": 37.7,
                "long": -122.4,
            ]
        )
    }
}
