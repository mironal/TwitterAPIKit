import TwitterAPIKit
import XCTest

class UploadMediaAppendRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let data = Data()
        let req = UploadMediaAppendRequestV1(
            mediaID: "m",
            filename: "f",
            mimeType: "m",
            media: data,
            segmentIndex: 1
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .upload)
        XCTAssertEqual(req.path, "/1.1/media/upload.json")
        XCTAssertEqual(req.bodyContentType, .multipartFormData)
        XCTAssertEqual(
            req.parameters as! [String: MultipartFormDataPart],
            [
                "command": MultipartFormDataPart.value(name: "command", value: "APPEND"),
                "media_id": MultipartFormDataPart.value(name: "media_id", value: "m"),
                "media": MultipartFormDataPart.data(name: "media", value: data, filename: "f", mimeType: "m"),
                "segment_index": MultipartFormDataPart.value(name: "segment_index", value: 1),
            ])
    }
}
