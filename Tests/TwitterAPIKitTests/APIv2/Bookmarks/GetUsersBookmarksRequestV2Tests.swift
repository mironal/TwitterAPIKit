import TwitterAPIKit
import XCTest

class GetUsersBookmarksRequestV2Tests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {
        let req = GetUsersBookmarksRequestV2(
            id: "_i_",
            expansions: [.authorID],
            maxResults: 12,
            mediaFields: [.height],
            paginationToken: "_p_",
            placeFields: [.name],
            pollFields: [.options],
            tweetFields: [.text],
            userFields: [.entities]
        )

        XCTAssertEqual(req.method, .get)
        XCTAssertEqual(req.baseURLType, .api)
        XCTAssertEqual(req.path, "/2/users/_i_/bookmarks")
        XCTAssertEqual(req.bodyContentType, .wwwFormUrlEncoded)
        AssertEqualAnyDict(
            req.parameters,
            [
                "expansions": "author_id",
                "max_results": 12,
                "media.fields": "height",
                "pagination_token": "_p_",
                "place.fields": "name",
                "poll.fields": "options",
                "tweet.fields": "text",
                "user.fields": "entities",
            ]
        )
    }

    func testDefaultArg() throws {
        let req = GetUsersBookmarksRequestV2(
            id: "_i_"
        )

        AssertEqualAnyDict(
            req.parameters,
            [:]
        )
    }
}
