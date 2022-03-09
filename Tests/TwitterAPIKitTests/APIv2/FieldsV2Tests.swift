import XCTest

@testable import TwitterAPIKit

class FieldsV2Tests: XCTestCase {

    // https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/tweet
    // Select Model -> Select Table in Dev tool -> exec ↓ code
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
        ].shuffled()

        XCTAssertEqual(
            allCases.commaSeparatedString,
            "attachments,author_id,context_annotations,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,non_public_metrics,organic_metrics,possibly_sensitive,promoted_metrics,public_metrics,referenced_tweets,reply_settings,source,text,withheld,~~~"
        )
    }

    func testTwitterUserFieldsV2() throws {
        let allCases: [TwitterUserFieldsV2] = [
            .createdAt,
            .description,
            .entities,
            .id,
            .location,
            .name,
            .pinnedTweetID,
            .profileImageUrl,
            .protected,
            .publicMetrics,
            .url,
            .username,
            .verified,
            .withheld,
            .other("~~"),
        ].shuffled()

        XCTAssertEqual(
            allCases.commaSeparatedString,
            "created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,public_metrics,url,username,verified,withheld,~~"
        )
    }

    func testTwitterPlaceFieldsV2() throws {
        let allCases: [TwitterPlaceFieldsV2] = [
            .containedWithin,
            .country,
            .countryCode,
            .fullName,
            .geo,
            .id,
            .name,
            .placeType,
            .other("~~~"),
        ].shuffled()

        XCTAssertEqual(
            allCases.commaSeparatedString,
            "contained_within,country,country_code,full_name,geo,id,name,place_type,~~~"
        )
    }
}
