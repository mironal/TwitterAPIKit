import XCTest

@testable import TwitterAPIKit

class FieldsV2Tests: XCTestCase {

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

        // curl https://api.twitter.com/2/openapi.json | jq '.components.parameters.TweetFieldsParameter.schema.items.enum | sort | join(",")'
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

        // curl https://api.twitter.com/2/openapi.json | jq '.components.parameters.UserFieldsParameter.schema.items.enum | sort | join(",")'
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

        // curl https://api.twitter.com/2/openapi.json | jq '.components.parameters.PlaceFieldsParameter.schema.items.enum | sort | join(",")'
        XCTAssertEqual(
            allCases.commaSeparatedString,
            "contained_within,country,country_code,full_name,geo,id,name,place_type,~~~"
        )
    }

    func testTwitterPollFieldsV2() throws {
        let allCases: [TwitterPollFieldsV2] = [
            .durationMinutes,
            .endDatetime,
            .id,
            .options,
            .votingStatus,
            .other("~~"),
        ].shuffled()

        // curl https://api.twitter.com/2/openapi.json | jq '.components.parameters.PollFieldsParameter.schema.items.enum | sort | join(",")'
        XCTAssertEqual(
            allCases.commaSeparatedString,
            "duration_minutes,end_datetime,id,options,voting_status,~~"
        )
    }

    func testTwitterMediaFieldsV2() throws {
        let allCases: [TwitterMediaFieldsV2] = [
            .durationMs,
            .height,
            .mediaKey,
            .previewImageUrl,
            .type,
            .url,
            .width,
            .publicMetrics,
            .nonPublicMetrics,
            .organicMetrics,
            .promotedMetrics,
            .altText,
            .other("~~~"),

        ].shuffled()

        // curl https://api.twitter.com/2/openapi.json | jq '.components.parameters.MediaFieldsParameter.schema.items.enum | sort | join(",")'

        // Note: `url` is missing in https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/media
        // https://twittercommunity.com/t/documentation-for-media-object-missing-url-field/163062
        XCTAssertEqual(
            allCases.commaSeparatedString,
            "alt_text,duration_ms,height,media_key,non_public_metrics,organic_metrics,preview_image_url,promoted_metrics,public_metrics,type,url,width,~~~"
        )
    }

    func testTwitterListFieldsV2() throws {
        let allCases: [TwitterListFieldsV2] = [
            .createdAt,
            .followerCount,
            .memberCount,
            .`private`,
            .description,
            .id,
            .name,
            .ownerID,
            .other("~"),
        ].shuffled()

        // curl https://api.twitter.com/2/openapi.json | jq '.components.parameters.ListFieldsParameter.schema.items.enum | sort | join(",")'

        XCTAssertEqual(
            allCases.commaSeparatedString,
            "created_at,description,follower_count,id,member_count,name,owner_id,private,~"
        )
    }

    func testTwitterSpaceFieldsV2() throws {
        let allCases: [TwitterSpaceFieldsV2] = [
            .hostIDs,
            .createdAt,
            .creatorID,
            .lang,
            .invitedUserIDs,
            .participantCount,
            .speakerIDs,
            .startedAt,
            .endedAt,
            .subscriberCount,
            .topicIDs,
            .title,
            .updatedAt,
            .scheduledStart,
            .isTicketed,
            .other("~~"),
        ].shuffled()

        // curl https://api.twitter.com/2/openapi.json | jq '.components.parameters.SpaceFieldsParameter.schema.items.enum | sort | join(",")'
        // Note: missing ended_at,subscriber_count,topic_ids in ↑
        XCTAssertEqual(
            allCases.commaSeparatedString,
            "created_at,creator_id,ended_at,host_ids,invited_user_ids,is_ticketed,lang,participant_count,scheduled_start,speaker_ids,started_at,subscriber_count,title,topic_ids,updated_at,~~"
        )
    }

    func testTwitterTopicFieldsV2() throws {
        let allCases: [TwitterTopicFieldsV2] = [
            .id,
            .name,
            .description,
            .other("~"),
        ].shuffled()

        // Not found in https://api.twitter.com/2/openapi.json

        XCTAssertEqual(
            allCases.commaSeparatedString,
            "description,id,name,~"
        )
    }
}
