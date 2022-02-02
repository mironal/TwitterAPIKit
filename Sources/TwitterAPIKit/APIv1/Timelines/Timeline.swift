import Foundation

public struct GetTimelineParameters: TwitterAPIParameters {

    public let count: Int?
    public let sinceID: String?
    public let maxID: String?
    public let trimUser: Bool?
    public let excludeReplies: Bool?
    public let includeEntities: Bool?

    var parameters: [String: Any]? {
        var p = [String: Any]()
        count.map { p["count"] = $0 }
        sinceID.map { p["since_id"] = $0 }
        maxID.map { p["max_id"] = $0 }
        trimUser.map { p["trim_user"] = $0 }
        excludeReplies.map { p["exclude_replies"] = $0 }
        includeEntities.map { p["include_entities"] = $0 }
        return p
    }

    public init(
        count: Int? = nil,
        sinceID: String? = nil,
        maxID: String? = nil,
        trimUser: Bool? = nil,
        excludeReplies: Bool? = nil,
        includeEntities: Bool? = nil
    ) {
        self.count = count
        self.sinceID = sinceID
        self.maxID = maxID
        self.trimUser = trimUser
        self.excludeReplies = excludeReplies
        self.includeEntities = includeEntities
    }
}

public struct GetUserTimelineParameters: TwitterAPIParameters {
    public enum Target {
        case userID(String)
        case screenName(String)
    }

    public let target: Target  // user_id or screen_name
    public let count: Int?
    public let sinceID: String?
    public let maxID: String?
    public let trimUser: Bool?
    public let excludeReplies: Bool?
    public let includeRTs: Bool?

    var parameters: [String: Any]? {
        var p = [String: Any]()

        switch target {
        case .userID(let string):
            p["user_id"] = string
        case .screenName(let string):
            p["screen_name"] = string
        }
        count.map { p["count"] = $0 }
        sinceID.map { p["since_id"] = $0 }
        maxID.map { p["max_id"] = $0 }
        trimUser.map { p["trim_user"] = $0 }
        excludeReplies.map { p["exclude_replies"] = $0 }
        includeRTs.map { p["include_rts"] = $0 }
        return p
    }

    public init(
        target: Target,
        count: Int? = nil,
        sinceID: String? = nil,
        maxID: String? = nil,
        trimUser: Bool? = nil,
        excludeReplies: Bool? = nil,
        includeRTs: Bool? = nil
    ) {
        self.target = target
        self.count = count
        self.sinceID = sinceID
        self.maxID = maxID
        self.trimUser = trimUser
        self.excludeReplies = excludeReplies
        self.includeRTs = includeRTs
    }
}

public struct PostUpdateStatusParameters: TwitterAPIParameters {
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

extension TwitterAPIKit: TwitterAPIv1 {
    public func getHomeTimeline(
        _ parameters: GetTimelineParameters,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.request(
            .get,
            path: "/1.1/statuses/home_timeline.json",
            with: parameters,
            completionHandler: completionHandler
        )
    }

    public func getMentionsTimeline(
        _ parameters: GetTimelineParameters,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.request(
            .get,
            path: "/1.1/statuses/mentions_timeline.json",
            with: parameters,
            completionHandler: completionHandler
        )
    }

    public func getUserTimeline(
        _ parameters: GetUserTimelineParameters,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.request(
            .get,
            path: "/1.1/statuses/user_timeline.json",
            with: parameters,
            completionHandler: completionHandler
        )
    }

    public func postUpdateStatus(
        _ parameters: PostUpdateStatusParameters,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), TwitterAPIKitError>) -> Void
    ) -> URLSessionTask {
        return session.request(
            .post,
            path: "/1.1/statuses/update.json",
            with: parameters,
            completionHandler: completionHandler)
    }
}
