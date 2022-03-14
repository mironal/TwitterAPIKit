import TwitterAPIKit
import XCTest

class PostAccountUpdateProfileImageRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let image = Data([0, 1, 2])
        let req = PostAccountUpdateProfileImageRequestV1(
            image: image,
            skipStatus: true,
            includeEntities: true
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/account/update_profile_image.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "image": "AAEC",
                "skip_status": true,
                "include_entities": true,
            ]
        )
    }

    func testDefaultArg() throws {
        let image = Data([0, 1, 2])
        let req = PostAccountUpdateProfileImageRequestV1(
            image: image
        )

        AssertEqualAnyDict(
            req.parameters,
            [
                "image": "AAEC"
            ]
        )
    }
}
