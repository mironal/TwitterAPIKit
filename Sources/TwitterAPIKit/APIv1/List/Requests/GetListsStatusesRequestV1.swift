import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/create-manage-lists/api-reference/get-lists-statuses
open class GetListsStatusesRequestV1: TwitterAPIRequest {

    public let list: TwitterListIdentifierV1
    public let count: Int?
    public let sinceID: String?
    public let maxID: String?
    public let includeEntities: Bool?
    public let includeRTs: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/lists/statuses.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        list.bind(param: &p)
        count.map { p["count"] = $0 }
        sinceID.map { p["since_id"] = $0 }
        maxID.map { p["max_id"] = $0 }
        includeEntities.map { p["include_entities"] = $0 }
        includeRTs.map { p["include_rts"] = $0 }
        return p
    }

    public init(
        list: TwitterListIdentifierV1,
        count: Int? = .none,
        sinceID: String? = .none,
        maxID: String? = .none,
        includeEntities: Bool? = .none,
        includeRTs: Bool? = .none
    ) {
        self.list = list
        self.count = count
        self.sinceID = sinceID
        self.maxID = maxID
        self.includeEntities = includeEntities
        self.includeRTs = includeRTs
    }
}
