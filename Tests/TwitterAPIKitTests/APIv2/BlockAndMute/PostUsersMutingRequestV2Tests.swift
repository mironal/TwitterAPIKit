import TwitterAPIKit
import XCTest

class PostUsersMutingRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostUsersMutingRequestV2(
            id: "_id_",
            targetUserID: "_targetUserID_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_id_/muting")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "target_user_id": "_targetUserID_"
            ]
        )
    }
}
