/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/mute-block-report-users/api-reference/post-users-report_spam
open class PostUsersReportSpamRequestV1: TwitterAPIRequest {

    public let user: TwitterUserIdentifierV1
    public let performBlock: Bool?

    public var method: HTTPMethod {
        return .post
    }
    public var path: String {
        return "/1.1/users/report_spam.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        user.bind(param: &p)
        performBlock.map { p["perform_block"] = $0 }
        return p
    }

    public init(
        user: TwitterUserIdentifierV1,
        performBlock: Bool? = .none
    ) {
        self.user = user
        self.performBlock = performBlock
    }
}
