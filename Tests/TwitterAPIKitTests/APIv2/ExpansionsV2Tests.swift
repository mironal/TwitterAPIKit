import XCTest

@testable import TwitterAPIKit

class ExpansionsV2Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testTwitterTweetExpansionsV2() throws {
        let allCases: [TwitterTweetExpansionsV2] = [
            .attachmentsPollIDs,
            .attachmentsMediaKeys,
            .authorID,
            .entitiesMentionsUsername,
            .geoPlaceID,
            .inReplyToUserID,
            .referencedTweetsID,
            .referencedTweetsIDAuthorID,
            .other("~~~"),
        ]

        // curl https://api.twitter.com/2/openapi.json | jq '.components.parameters.TweetExpansionsParameter.schema.items.enum | sort | join(",")'
        XCTAssertEqual(
            allCases.commaSeparatedString,
            "attachments.media_keys,attachments.poll_ids,author_id,entities.mentions.username,geo.place_id,in_reply_to_user_id,referenced_tweets.id,referenced_tweets.id.author_id,~~~"
        )
    }

    func testTwitterUserExpansionsV2() throws {

        let allCases: [TwitterUserExpansionsV2] = [
            .pinnedTweetID,
            .other("~~~"),
        ]

        // curl https://api.twitter.com/2/openapi.json | jq '.components.parameters.UserExpansionsParameter.schema.items.enum | sort | join(",")'
        XCTAssertEqual(
            allCases.commaSeparatedString,
            "pinned_tweet_id,~~~"
        )
    }
}
