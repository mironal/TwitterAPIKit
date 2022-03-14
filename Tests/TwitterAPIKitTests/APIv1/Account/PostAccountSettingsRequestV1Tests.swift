import TwitterAPIKit
import XCTest

class PostAccountSettingsRequestV1Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostAccountSettingsRequestV1(
            lang: "_l_",
            timeZone: "_t_",
            startSleepTime: 1,
            endSleepTime: 10,
            sleepTimeEnabled: true,
            trendLocationWoeid: "_t_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/1.1/account/settings.json")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "lang": "_l_",
                "time_zone": "_t_",
                "start_sleep_time": 1,
                "end_sleep_time": 10,
                "sleep_time_enabled": true,
                "trend_location_woeid": "_t_",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = PostAccountSettingsRequestV1()

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
