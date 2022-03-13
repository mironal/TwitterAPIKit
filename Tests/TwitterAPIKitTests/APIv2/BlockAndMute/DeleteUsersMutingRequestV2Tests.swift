import TwitterAPIKit
import XCTest

class DeleteUsersMutingRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = DeleteUsersMutingRequestV2(
            sourceUserID: "_sourceUserID_",
            targetUserID: "_targetUserID_"
        )

        XCTAssertEqual(req.method, .delete)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_sourceUserID_/muting/_targetUserID_")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(req.parameters, [:])
    }
}
