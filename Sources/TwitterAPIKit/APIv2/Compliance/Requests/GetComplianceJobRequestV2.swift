import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/get-compliance-jobs-id
open class GetComplianceJobRequestV2: TwitterAPIRequest {

    public let id: Int

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/compliance/jobs/\(id)"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init(
        id: Int
    ) {
        self.id = id
    }
}
