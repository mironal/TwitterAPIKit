import TwitterAPIKit
import XCTest

class DeleteListRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = DeleteListRequestV2(
            id: "_id_"
        )

        XCTAssertEqual(req.method, .delete)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/lists/_id_")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(req.parameters, [:])
    }
}
