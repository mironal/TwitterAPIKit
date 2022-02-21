import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/post-compliance-jobs
open class PostComplianceJobsRequestV2: TwitterAPIRequest {

    public let type: TwitterComplianceJobTypeV2
    public let name: String?
    public let resumable: Bool?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/2/compliance/jobs"
    }

    public var bodyContentType: BodyContentType {
        return .json
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        type.bind(param: &p)
        name.map { p["name"] = $0 }
        resumable.map { p["resumable"] = $0 }
        return p
    }

    public init(
        type: TwitterComplianceJobTypeV2,
        name: String? = .none,
        resumable: Bool? = .none
    ) {
        self.type = type
        self.name = name
        self.resumable = resumable
    }
}
