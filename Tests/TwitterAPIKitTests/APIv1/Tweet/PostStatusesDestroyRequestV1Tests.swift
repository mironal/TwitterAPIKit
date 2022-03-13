import TwitterAPIKit
import XCTest

class PostStatusesDestroyRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostStatusesDestroyRequestV1(
            id: "_i_",
            trimUser: true
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/statuses/destroy/_i_.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "trim_user": true
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostStatusesDestroyRequestV1(
            id: "_i_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
