import TwitterAPIKit
import XCTest

class DeleteListsMembersRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = DeleteListsMembersRequestV2(
            id: "_id_",
            userID: "_userID_"
        )

        XCTAssertEqual(req.method, .delete)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/lists/_id_/members/_userID_")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(req.parameters, [:])
    }
}
