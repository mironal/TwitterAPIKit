import TwitterAPIKit
import XCTest

class PostMediaSubtitlesCreateRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostMediaSubtitlesCreateRequestV1(
            mediaID: "mediaID",
            mediaCategory: "c",
            subtitles: [
                .init(
                    mediaID: "subtitleMediaID",
                    languageCode: "l",
                    displayName: "d"
                )
            ]
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .upload)
        XCTAssertEqual(req.path, "/1.1/media/subtitles/create.json")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "media_id": "mediaID",
                "media_category": "c",
                "subtitle_info": [
                    "subtitles": [
                        [
                            "media_id": "subtitleMediaID",
                            "language_code": "l",
                            "display_name": "d",
                        ]
                    ]
                ],
            ])
    }
}
