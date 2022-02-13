import TwitterAPIKit
import XCTest

class GetUsersTweetsRequestV2Tests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let user = GetUsersTweetsRequestV2(
            id: "_id_",
            endTime: Date(timeIntervalSince1970: 60),
            exclude: .replies,
            startTime: Date(timeIntervalSince1970: 0)
        )

        XCTAssertEqual(user.method, .get)
        XCTAssertEqual(user.path, "/2/users/_id_/tweets")

        AssertEqualAnyDict(
            user.parameters,
            [
                "exclude": "replies",
                "end_time": "1970-01-01T00:01:00Z",
                "start_time": "1970-01-01T00:00:00Z",
            ])
    }
}
