import Foundation

public protocol ComplianceAPIv2 {

    /// https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/get-compliance-jobs-id
    func getComplianceJob(
        _ request: GetComplianceJobRequestV2
    ) -> TwitterAPISessionJSONTask

    /// https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/get-compliance-jobs
    func getComplianceJobj(
        _ request: GetComplianceJobsRequestV2
    ) -> TwitterAPISessionJSONTask
}

extension TwitterAPIKit.TwitterAPIImplV2: ComplianceAPIv2 {

    func getComplianceJob(_ request: GetComplianceJobRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }

    func getComplianceJobj(_ request: GetComplianceJobsRequestV2) -> TwitterAPISessionJSONTask {
        return session.send(request)
    }
}
