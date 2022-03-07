import TwitterAPIKit
import XCTest

class DeleteUsersBlockingRequestV2Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = DeleteUsersBlockingRequestV2(sourceUserID: "s", targetUserID: "t")

        XCTAssertEqual(req.method, .delete)
        XCTAssertEqual(req.path, "/2/users/s/blocking/t")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(req.parameters, [:])
    }
}
