import TwitterAPIKit
import XCTest

class PostTweetsSearchStreamRulesRequestV2Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        XCTContext.runActivity(named: "with only required parameters") { _ in

            let add = PostTweetsSearchStreamRulesRequestV2(operation: .add([.init(value: "value", tag: "tag")]))

            XCTAssertEqual(add.method, .post)
            XCTAssertEqual(add.path, "/2/tweets/search/stream/rules")
            XCTAssertEqual(add.bodyContentType, .json)

            AssertEqualAnyDict(add.parameters, [:])

        }
    }
}
