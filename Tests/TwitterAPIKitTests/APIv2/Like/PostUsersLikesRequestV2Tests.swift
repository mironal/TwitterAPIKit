import TwitterAPIKit
import XCTest

class PostUsersLikesRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = PostUsersLikesRequestV2(
            id: "_id_",
            tweetID: "_tweetID_"
        )

        XCTAssertEqual(req.method, .post)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_id_/likes")
        XCTAssertEqual(req.bodyContentType, .json)
        AssertEqualAnyDict(
            req.parameters,
            [
                "tweet_id": "_tweetID_"
            ]
        )
    }
}
