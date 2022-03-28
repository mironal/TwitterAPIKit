import TwitterAPIKit
import XCTest

class PostCollectionsCreateRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostCollectionsCreateRequestV1(
            name: "_n_",
            url: "_u_",
            description: "_d_",
            timelineOrder: .curationReverseChron
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/collections/create.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "name": "_n_",
                "url": "_u_",
                "description": "_d_",
                "timeline_order": "curation_reverse_chron",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostCollectionsCreateRequestV1(
            name: "n"
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "name": "n"
            ]
        )
    }
}
