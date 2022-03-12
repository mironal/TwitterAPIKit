import TwitterAPIKit
import XCTest

class DeleteUsersFollowingRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = DeleteUsersFollowingRequestV2(
            sourceUserID: "_sourceUserID_",
            targetUserID: "_targetUserID_"
        )

        XCTAssertEqual(req.method, .delete)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_sourceUserID_/following/_targetUserID_")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(req.parameters, [:])
    }
}
