import TwitterAPIKit
import XCTest

class PutTweetsHiddenRequestV2Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        let req = PutTweetsHiddenRequestV2(id: "12", hidden: true)
        XCTAssertEqual(req.method, .put)
        XCTAssertEqual(req.path, "/2/tweets/12/hidden")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(req.parameters, ["hidden": true])
    }
}
