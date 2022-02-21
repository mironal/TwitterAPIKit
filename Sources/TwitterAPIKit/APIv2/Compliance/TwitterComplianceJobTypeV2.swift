import Foundation

public enum TwitterComplianceJobTypeV2: String {
    case tweets
    case users

    func bind(param: inout [String: Any]) {
        param["type"] = rawValue
    }
}
