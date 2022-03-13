import TwitterAPIKit
import XCTest

class PostUsersBlockingRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostUsersBlockingRequestV2(
            id: "_id_",
            targetUserID: "_targetUserID_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_id_/blocking")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "target_user_id": "_targetUserID_"
            ])
    }
}
