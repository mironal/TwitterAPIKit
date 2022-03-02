import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/search/api-reference/get-search-tweets
open class GetSearchTweetsRequestV1: TwitterAPIRequest {

    public enum ResultType: String {
        case mixed
        case recent
        case popular
    }

    public let q: String
    public let lang: String?
    public let count: Int?
    public let until: String?
    public let maxID: String?
    public let locale: String?
    public let geocode: String?
    public let sinceID: String?
    public let resultType: ResultType?
    public let includeEntities: Bool?

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/search/tweets.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        p["q"] = q
        lang.map { p["lang"] = $0 }
        count.map { p["count"] = $0 }
        until.map { p["until"] = $0 }
        maxID.map { p["max_id"] = $0 }
        locale.map { p["locale"] = $0 }
        geocode.map { p["geocode"] = $0 }
        sinceID.map { p["since_id"] = $0 }
        resultType.map { p["result_type"] = $0.rawValue }
        includeEntities.map { p["include_entities"] = $0 }
        return p
    }

    public init(
        q: String,
        lang: String? = .none,
        count: Int? = .none,
        until: String? = .none,
        maxID: String? = .none,
        locale: String? = .none,
        geocode: String? = .none,
        sinceID: String? = .none,
        resultType: ResultType? = .none,
        includeEntities: Bool? = .none
    ) {
        self.q = q
        self.lang = lang
        self.count = count
        self.until = until
        self.maxID = maxID
        self.locale = locale
        self.geocode = geocode
        self.sinceID = sinceID
        self.resultType = resultType
        self.includeEntities = includeEntities
    }
}
