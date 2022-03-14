import TwitterAPIKit
import XCTest

class PostAccountUpdateProfileBannerRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let banner = Data([0, 1, 2])
        let req = PostAccountUpdateProfileBannerRequestV1(
            banner: banner,
            width: 2,
            height: 3,
            offsetTop: 4,
            offsetLeft: 5
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/account/update_profile_banner.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)

        /*
         012 -> 00000000 00000001 00000010

         000000: A
         000000: A
         000100: E
         000010: C
         */

        AssertEqualAnyDict(
            req.parameters,
            [
                "banner": "AAEC",
                "width": 2,
                "height": 3,
                "offset_top": 4,
                "offset_left": 5,
            ]
        )
    }

    func testDefaultArg() throws {
        let banner = Data([0, 1])
        let req = PostAccountUpdateProfileBannerRequestV1(
            banner: banner
        )

        /*
         01

         000000: A
         000000: A
         000100: E

         */
        AssertEqualAnyDict(
            req.parameters,
            [
                "banner": "AAE="
            ]
        )
    }
}
