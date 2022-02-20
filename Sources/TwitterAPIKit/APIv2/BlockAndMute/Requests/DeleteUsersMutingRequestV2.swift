import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/delete-users-user_id-muting
open class DeleteUsersMutingRequestV2: TwitterAPIRequest {

    public let sourceUserID: String
    public let targetUserID: String

    public var method: HTTPMethod {
        return .delete
    }

    public var path: String {
        return "/2/users/\(sourceUserID)/muting/\(targetUserID)"
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
