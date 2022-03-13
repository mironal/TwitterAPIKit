import TwitterAPIKit
import XCTest

class GetUsersByUsernameRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersByUsernameRequestV2(
            username: "_username_",
            expansions: [.pinnedTweetID],
            tweetFields: [.withheld],
            userFields: [.profileImageUrl]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/by/username/_username_")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "pinned_tweet_id",
                "tweet.fields": "withheld",
                "user.fields": "profile_image_url",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetUsersByUsernameRequestV2(
            username: "_username_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
