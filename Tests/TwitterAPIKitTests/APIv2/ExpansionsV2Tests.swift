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

    func testTwitterTweetExpansionsV2All() throws {
        XCTAssertEqual(TwitterTweetExpansionsV2.all.count, 8)
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

    func testTwitterUserExpansionsV2All() throws {
        XCTAssertEqual(TwitterUserExpansionsV2.all.count, 1)
    }

    func testTwitterListExpansionsV2() throws {
        let allCases: [TwitterListExpansionsV2] = [
            .ownerID,
            .other("~~~"),
        ]

        // curl https://api.twitter.com/2/openapi.json | jq '.components.parameters.ListExpansionsParameter.schema.items.enum | sort | join(",")'
        XCTAssertEqual(
            allCases.commaSeparatedString,
            "owner_id,~~~"
        )
    }

    func testTwitterListExpansionsV2All() throws {
        XCTAssertEqual(TwitterListExpansionsV2.all.count, 1)
    }

    func testTwitterSpaceExpansionsV2() throws {
        let allCases: [TwitterSpaceExpansionsV2] = [
            .invitedUserIDs,
            .speakerIDs,
            .creatorID,
            .hostIDs,
            .topicIDs,
            .other("~~~"),
        ]

        // curl https://api.twitter.com/2/openapi.json | jq '.components.parameters.SpaceExpansionsParameter.schema.items.enum | sort | join(",")'
        XCTAssertEqual(
            allCases.commaSeparatedString,
            "creator_id,host_ids,invited_user_ids,speaker_ids,topic_ids,~~~"
        )
    }

    func testTwitterSpaceExpansionsV2All() throws {
        XCTAssertEqual(TwitterSpaceExpansionsV2.all.count, 5)
    }

    func testTwitterDmEventExpansionsV2() throws {
        let allCases: [TwitterDmEventExpansionsV2] = [
            .attachmentsMediaKeys,
            .participantIDs,
            .referencedTweetsID,
            .senderID,
            .other("~~~"),
        ].shuffled()

        // curl https://api.twitter.com/2/openapi.json | jq '.components.parameters.DmEventExpansionsParameter.schema.items.enum | sort | join(",")'
        XCTAssertEqual(
            allCases.commaSeparatedString,
            "attachments.media_keys,participant_ids,referenced_tweets.id,sender_id,~~~"
        )
    }

    func testTwitterDmEventExpansionsV2All() throws {
        XCTAssertEqual(TwitterDmEventExpansionsV2.all.count, 4)
    }
}
