import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/manage-account-settings/api-reference/post-account-settings
open class PostAccountSettingsRequestV1: TwitterAPIRequest {

    /// two letter ISO 639-1
    public let lang: String?
    /// RailsTimeZone
    public let timeZone: String?
    /// ISO 8601 (00-23)
    public let startSleepTime: Int?
    /// ISO 8601 (00-23)
    public let endSleepTime: Int?

    public let sleepTimeEnabled: Bool?
    public let trendLocationWoeid: String?

    public var method: HTTPMethod {
        return .post
    }

    public var path: String {
        return "/1.1/account/settings.json"
    }

    open var parameters: [String: Any] {
        var p = [String: Any]()
        lang.map { p["lang"] = $0 }
        timeZone.map { p["time_zone"] = $0 }
        startSleepTime.map { p["start_sleep_time"] = $0 }
        endSleepTime.map { p["end_sleep_time"] = $0 }
        sleepTimeEnabled.map { p["sleep_time_enabled"] = $0 }
        trendLocationWoeid.map { p["trend_location_woeid"] = $0 }
        return p
    }

    public init(
        lang: String? = .none,
        timeZone: String? = .none,
        startSleepTime: Int? = .none,
        endSleepTime: Int? = .none,
        sleepTimeEnabled: Bool? = .none,
        trendLocationWoeid: String? = .none
    ) {
        self.lang = lang
        self.timeZone = timeZone
        self.startSleepTime = startSleepTime
        self.endSleepTime = endSleepTime
        self.sleepTimeEnabled = sleepTimeEnabled
        self.trendLocationWoeid = trendLocationWoeid
    }
}
