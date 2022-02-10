import TwitterAPIKit
import XCTest

class ListRequestV1Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    // https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-list
    func testGetListsListRequestV1() throws {

        XCTContext.runActivity(named: "with only required parameters") { _ in
            let list = GetListsListRequestV1(user: .userID("1234"))

            XCTAssertEqual(list.method, .get)
            XCTAssertEqual(list.path, "/1.1/lists/list.json")
            AssertEqualAnyDict(list.parameters, ["user_id": "1234"])
        }

        XCTContext.runActivity(named: "with all parameters") { _ in
            let list = GetListsListRequestV1(user: .screenName("name"), reverse: true)
            AssertEqualAnyDict(list.parameters, ["screen_name": "name", "reverse": true])
        }

    }
}
