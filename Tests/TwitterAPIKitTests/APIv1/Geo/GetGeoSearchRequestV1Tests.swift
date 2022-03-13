import TwitterAPIKit
import XCTest

class GetGeoSearchRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetGeoSearchRequestV1(
            location: .coordinate(.init(lat: 10.12, long: -20)),
            maxResults: 13,
            granularity: .country
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/geo/search.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "lat": 10.12,
                "long": -20,
                "max_results": 13,
                "granularity": "country",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetGeoSearchRequestV1(
            location: .coordinate(.init(lat: 10.123, long: -20.1))
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "lat": 10.123,
                "long": -20.1,
            ]
        )
    }
}
