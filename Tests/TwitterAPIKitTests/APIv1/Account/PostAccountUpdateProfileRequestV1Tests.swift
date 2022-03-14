import TwitterAPIKit
import XCTest

class PostAccountUpdateProfileRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostAccountUpdateProfileRequestV1(
            url: "_u_",
            name: "_n_",
            location: "_l_",
            skipStatus: true,
            description: "_d_",
            includeEntities: true,
            profileLinkColor: "_p_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/account/update_profile.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "url": "_u_",
                "name": "_n_",
                "location": "_l_",
                "skip_status": true,
                "description": "_d_",
                "include_entities": true,
                "profile_link_color": "_p_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostAccountUpdateProfileRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
