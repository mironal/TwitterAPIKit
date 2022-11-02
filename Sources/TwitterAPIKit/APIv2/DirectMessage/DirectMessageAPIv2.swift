import Foundation

open class DirectMessageAPIv2: TwitterAPIBase {
    /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/lookup/api-reference/get-dm_events
    public func getDmEvents(
        _ request: GetDmEventsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/lookup/api-reference/get-dm_conversations-with-participant_id-dm_events
    public func getDmEventsWithParticipantId(
        _ request: GetDmConversationsWithParticipantIdDmEventsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/lookup/api-reference/get-dm_conversations-dm_conversation_id-dm_events
    public func getDmEventsByConversationsId(
        _ request: GetDmConversationsIdDmEventsRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/manage/api-reference/post-dm_conversations-dm_conversation_id-messages
    public func postDmConversationById(
        _ request: PostDmConversationByIdRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/manage/api-reference/post-dm_conversations-with-participant_id-messages
    public func postDmConversationWithUser(
        _ request: PostDmConversationWithUserRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/manage/api-reference/post-dm_conversations
    public func postDmConversation(
        _ request: PostDmConversationRequestV2
    ) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
