import Foundation

open class GetTweetsRequestV2: TwitterAPIRequest {
    let ids: [String]

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/2/tweets"
    }

    open var parameters: [String: Any]? {
        var p = [String: Any]()
        p["ids"] = ids.joined(separator: ",")
        return p
    }

    public init(
        ids: [String]
    ) {
        self.ids = ids

    }

}
