import TwitterAPIKit
import XCTest

class PostMediaMetadataCreateRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostMediaMetadataCreateRequestV1(
            mediaID: "m",
            altText: "alt"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .upload)
        XCTAssertEqual(req.path, "/1.1/media/metadata/create.json")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "media_id": "m",
                "alt_text": ["text": "alt"],
            ]
        )
    }
}
