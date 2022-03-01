import TwitterAPIKit
import XCTest

class DeleteTweetRequestV2Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let request = DeleteTweetRequestV2(id: "123")
        XCTAssertEqual(request.method, .delete)
        XCTAssertEqual(request.path, "/2/tweets/123")
        XCTAssertEqual(request.bodyContentType, .wwwFormUrlEncoded)
        XCTAssertTrue(request.parameters.isEmpty)
    }
}
