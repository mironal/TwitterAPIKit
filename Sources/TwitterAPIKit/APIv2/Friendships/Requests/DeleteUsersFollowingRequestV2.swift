import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/delete-users-source_id-following
open class DeleteUsersFollowingRequestV2: TwitterAPIRequest {

    public let sourceUserID: String
    public let targetUserID: String

    public var method: HTTPMethod {
        return .delete
    }

    public var path: String {
        return "/2/users/\(sourceUserID)/following/\(targetUserID)"
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
