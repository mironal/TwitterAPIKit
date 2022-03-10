import TwitterAPIKit
import XCTest

class GetUploadMediaStatusRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUploadMediaStatusRequestV1(mediaID: "m")

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.path, "/1.1/media/upload.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "command": "STATUS",
                "media_id": "m",
            ])
    }

}
