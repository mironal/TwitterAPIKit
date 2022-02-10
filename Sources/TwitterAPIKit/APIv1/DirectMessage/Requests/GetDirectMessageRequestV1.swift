import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/direct-messages/sending-and-receiving/api-reference/get-event

open class GetDirectMessageRequestV1: TwitterAPIRequest {

    public let id: String

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/direct_messages/events/show.json"
    }

    open var parameters: [String: Any] {
        return ["id": id]
    }

    public init(id: String) {
        self.id = id
    }
}
