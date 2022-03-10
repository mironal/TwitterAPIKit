import TwitterAPIKit
import XCTest

class PostMediaSubtitlesDeleteRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostMediaSubtitlesDeleteRequestV1(
            mediaID: "m",
            mediaCategory: "c",
            subtitleLanguageCodes: ["l1", "l2"]
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.path, "/1.1/media/subtitles/delete.json")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "media_id": "m",
                "media_category": "c",
                "subtitle_info": [
                    "subtitles": [
                        ["language_code": "l1"],
                        ["language_code": "l2"],
                    ]
                ],
            ]
        )
    }
}
