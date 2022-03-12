import TwitterAPIKit
import XCTest

class GetSpaceRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetSpaceRequestV2(
            id: "_i_",
            expansions: [.hostIDs],
            spaceFields: [.title],
            topicFields: [.name],
            userFields: [.username]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/spaces/_i_")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "host_ids",
                "space.fields": "title",
                "topic.fields": "name",
                "user.fields": "username",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetSpaceRequestV2(
            id: "_i_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
