import TwitterAPIKit
import XCTest

class GetGeoReverseGeocodeRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testAccuracy() throws {
        XCTContext.runActivity(named: "ft") { _ in
            let req = GetGeoReverseGeocodeRequestV1(
                location: .init(lat: 1, long: 2.5),
                accuracy: .ft(2),
                maxResults: 10,
                granularity: .neighborhood
            )

            XCTAssertEqual(req.method, .get)
            XCTAssertEqual(req.baseURLType, .api)
            XCTAssertEqual(req.path, "/1.1/geo/reverse_geocode.json")
            XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
            AssertEqualAnyDict(
                req.parameters,
                [
                    "lat": 1,
                    "long": 2.5,
                    "accuracy": "2ft",
                    "max_results": 10,
                    "granularity": "neighborhood",
                ]
            )
        }
        XCTContext.runActivity(named: "meter") { _ in

            let req = GetGeoReverseGeocodeRequestV1(
                location: .init(lat: 1, long: 2.5),
                accuracy: .m(3),
                maxResults: 10,
                granularity: .neighborhood
            )

            AssertEqualAnyDict(
                req.parameters,
                [
                    "lat": 1,
                    "long": 2.5,
                    "accuracy": "3m",
                    "max_results": 10,
                    "granularity": "neighborhood",
                ]
            )
        }
    }

    func testGranularity() throws {
        XCTContext.runActivity(named: "neighborhood") { _ in
            let req = GetGeoReverseGeocodeRequestV1(
                location: .init(lat: 1, long: 2.5),
                accuracy: .ft(2),
                maxResults: 10,
                granularity: .neighborhood
            )

            AssertEqualAnyDict(
                req.parameters,
                [
                    "lat": 1,
                    "long": 2.5,
                    "accuracy": "2ft",
                    "max_results": 10,
                    "granularity": "neighborhood",
                ]
            )
        }
        XCTContext.runActivity(named: "city") { _ in
            let req = GetGeoReverseGeocodeRequestV1(
                location: .init(lat: 1, long: 2.5),
                accuracy: .ft(2),
                maxResults: 10,
                granularity: .city
            )

            AssertEqualAnyDict(
                req.parameters,
                [
                    "lat": 1,
                    "long": 2.5,
                    "accuracy": "2ft",
                    "max_results": 10,
                    "granularity": "city",
                ]
            )
        }
        XCTContext.runActivity(named: "admin") { _ in
            let req = GetGeoReverseGeocodeRequestV1(
                location: .init(lat: 1, long: 2.5),
                accuracy: .ft(2),
                maxResults: 10,
                granularity: .admin
            )

            AssertEqualAnyDict(
                req.parameters,
                [
                    "lat": 1,
                    "long": 2.5,
                    "accuracy": "2ft",
                    "max_results": 10,
                    "granularity": "admin",
                ]
            )
        }
        XCTContext.runActivity(named: "country") { _ in
            let req = GetGeoReverseGeocodeRequestV1(
                location: .init(lat: 1, long: 2.5),
                accuracy: .ft(2),
                maxResults: 10,
                granularity: .country
            )

            AssertEqualAnyDict(
                req.parameters,
                [
                    "lat": 1,
                    "long": 2.5,
                    "accuracy": "2ft",
                    "max_results": 10,
                    "granularity": "country",
                ]
            )
        }
    }

    func testDefaultArg() throws {
        let req = GetGeoReverseGeocodeRequestV1(
            location: .init(lat: -10, long: 100)
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "lat": -10,
                "long": 100,
            ]
        )
    }
}
