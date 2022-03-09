import TwitterAPIKit
import XCTest

class GetTweetsRequestV2Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        XCTContext.runActivity(named: "with only required parameters") { _ in

            let tweet = GetTweetsRequestV2(ids: ["123", "abc"])

            XCTAssertEqual(tweet.method, .get)
            XCTAssertEqual(tweet.path, "/2/tweets")
            AssertEqualAnyDict(tweet.parameters, ["ids": "123,abc"])
        }

        XCTContext.runActivity(named: "with all parameters") { _ in

            let tweet = GetTweetsRequestV2(
                ids: ["1234"],
                expansions: [.attachmentsMediaKeys],
                mediaFields: [.url, .altText],
                placeFields: [.name, .id],
                pollFields: [.id],
                tweetFields: [.text, .id],
                userFields: [.entities]
            )

            AssertEqualAnyDict(
                tweet.parameters,
                [
                    "ids": "1234",
                    "expansions": "attachments.media_keys",
                    "media.fields": "alt_text,url",
                    "place.fields": "id,name",
                    "poll.fields": "id",
                    "tweet.fields": "id,text",
                    "user.fields": "entities",
                ])
        }
    }

}
