import TwitterAPIKit
import XCTest

class GetListsTweetsRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetListsTweetsRequestV2(
            id: "_id_",
            expansions: [.referencedTweetsIDAuthorID],
            maxResults: 10,
            paginationToken: "t",
            tweetFields: [.text],
            userFields: [.profileImageUrl]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/lists/_id_/tweets")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "referenced_tweets.id.author_id",
                "max_results": 10,
                "pagination_token": "t",
                "tweet.fields": "text",
                "user.fields": "profile_image_url",

            ])
    }

    func testDefaultArg() throws {
        let req = GetListsTweetsRequestV2(
            id: "_id_"
        )

        AssertEqualAnyDict(req.parameters, [:])
    }
}
