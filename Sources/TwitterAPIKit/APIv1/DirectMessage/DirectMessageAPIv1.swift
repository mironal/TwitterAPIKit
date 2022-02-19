import Foundation

public protocol DirectMessageAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/sending-and-receiving/api-reference/new-event
    @discardableResult
    func postDirectMessage(
        _ request: PostDirectMessageRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/sending-and-receiving/api-reference/delete-message-event
    @discardableResult
    func deleteDirectMessage(
        _ request: DeleteDirectMessageRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/sending-and-receiving/api-reference/get-event
    @discardableResult
    func getDirectMessage(
        _ request: GetDirectMessageRequestV1
    ) -> TwitterAPISessionTask

    /// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/sending-and-receiving/api-reference/list-events
    @discardableResult
    func getDirectMessageList(
        _ request: GetDirectMessageListRequestV1
    ) -> TwitterAPISessionTask
}

extension TwitterAPIKit.TwitterAPIImplV1: DirectMessageAPIv1 {

    public func postDirectMessage(
        _ request: PostDirectMessageRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func deleteDirectMessage(
        _ request: DeleteDirectMessageRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getDirectMessage(
        _ request: GetDirectMessageRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }

    public func getDirectMessageList(
        _ request: GetDirectMessageListRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }
}
