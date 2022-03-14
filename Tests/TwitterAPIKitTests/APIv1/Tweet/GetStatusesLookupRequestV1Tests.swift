import TwitterAPIKit
import XCTest

class GetStatusesLookupRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetStatusesLookupRequestV1(
            ids: ["a", "b"],
            map: true,
            trimUser: true,
            includeCardUri: true,
            includeEntities: true,
            includeExtAltText: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/statuses/lookup.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "id": "a,b",
                "map": true,
                "trim_user": true,
                "include_card_uri": true,
                "include_entities": true,
                "include_ext_alt_text": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetStatusesLookupRequestV1(
            ids: ["a"]
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "id": "a"
            ]
        )
    }
}
