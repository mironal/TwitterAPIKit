import TwitterAPIKit
import XCTest

class GetSearchTweetsRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        let req = GetSearchTweetsRequestV1(
            q: "あああ",
            lang: "lang",
            count: 20,
            until: "2015-07-19",
            maxID: "100",
            locale: "locale",
            geocode: "geo",
            sinceID: "10",
            resultType: .popular,
            includeEntities: true
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.path, "/1.1/search/tweets.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "include_entities": true,
                "lang": "lang",
                "since_id": "10",
                "q": "あああ",
                "until": "2015-07-19",
                "geocode": "geo",
                "result_type": "popular",
                "count": 20,
                "max_id": "100",
                "locale": "locale",
            ])
    }

    func testDefaultArg() throws {
        let req = GetSearchTweetsRequestV1(
            q: "_q_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "q": "_q_"
            ]
        )
    }
}
