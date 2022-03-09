import TwitterAPIKit
import XCTest

class GetTweetRequestV2Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        XCTContext.runActivity(named: "with only required parameters") { _ in

            let tweet = GetTweetRequestV2(id: "123")

            XCTAssertEqual(tweet.method, .get)
            XCTAssertEqual(tweet.path, "/2/tweets/123")
            AssertEqualAnyDict(tweet.parameters, [:])
        }

        XCTContext.runActivity(named: "with all parameters") { _ in

            let tweet = GetTweetRequestV2(
                id: "1234",
                expansions: [.authorID],
                mediaFields: [.url, .altText],
                placeFields: [.name, .id],
                pollFields: [.id],
                tweetFields: [.text, .id],
                userFields: [.entities]
            )

            AssertEqualAnyDict(
                tweet.parameters,
                [
                    "expansions": "author_id",
                    "media.fields": "alt_text,url",
                    "place.fields": "id,name",
                    "poll.fields": "id",
                    "tweet.fields": "id,text",
                    "user.fields": "entities",
                ])
        }
    }

}
