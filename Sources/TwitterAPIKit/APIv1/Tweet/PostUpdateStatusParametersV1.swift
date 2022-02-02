import Foundation

public struct PostUpdateStatusParametersV1: TwitterAPIParameters {

    // TODO: Other parameters

    public let status: String

    var parameters: [String: Any]? {
        var p = [String: Any]()
        p["status"] = status
        return p
    }

    public init(
        status: String
    ) {
        self.status = status
    }
}
