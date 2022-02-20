import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/delete-users-user_id-blocking
open class DeleteUsersBlockingRequestV2: TwitterAPIRequest {

    public let sourceUserID: String
    public let targetUserID: String

    public var method: HTTPMethod {
        return .delete
    }

    public var path: String {
        return "/2/users/\(sourceUserID)/blocking/\(targetUserID)"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init(
        sourceUserID: String,
        targetUserID: String
    ) {
        self.sourceUserID = sourceUserID
        self.targetUserID = targetUserID
    }
}
