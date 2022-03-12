import TwitterAPIKit
import XCTest

class GetSpacesRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetSpacesRequestV2(
            ids: ["a", "b"],
            expansions: [.speakerIDs],
            spaceFields: [.lang],
            topicFields: [.description],
            userFields: [.withheld]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/spaces")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "ids": "a,b",
                "expansions": "speaker_ids",
                "space.fields": "lang",
                "topic.fields": "description",
                "user.fields": "withheld",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetSpacesRequestV2(
            ids: ["a", "b", "あ"]
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "ids": "a,b,あ"
            ]
        )
    }
}
