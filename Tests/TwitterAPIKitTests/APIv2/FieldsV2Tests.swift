import XCTest

@testable import TwitterAPIKit

class FieldsV2Tests: XCTestCase {

    // https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/tweet
    // [...$0.rows].slice(1).map(tr => { return tr.cells[0].textContent.replace("(default)", "").trim()}).sort().join(",")

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testTwitterTweetFieldsV2() throws {

        let allCases: [TwitterTweetFieldsV2] = [
            .attachments,
            .authorID,
            .contextAnnotations,
            .conversationID,
            .createdAt,
            .entities,
            .geo,
            .id,
            .inReplyToUserID,
            .lang,
            .nonPublicMetrics,
            .publicMetrics,
            .organicMetrics,
            .promotedMetrics,
            .possiblySensitive,
            .referencedTweets,
            .replySettings,
            .source,
            .text,
            .withheld,
            .other("~~~"),
        ]

        XCTAssertEqual(
            allCases.commaSeparatedString,
            "attachments,author_id,context_annotations,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,non_public_metrics,organic_metrics,possibly_sensitive,promoted_metrics,public_metrics,referenced_tweets,reply_settings,source,text,withheld,~~~"
        )
    }
}
