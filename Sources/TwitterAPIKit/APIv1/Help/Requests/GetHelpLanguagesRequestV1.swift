import Foundation

/// https://developer.twitter.com/en/docs/twitter-api/v1/developer-utilities/supported-languages/api-reference/get-help-languages
open class GetHelpLanguagesRequestV1: TwitterAPIRequest {

    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/1.1/help/languages.json"
    }

    open var parameters: [String: Any] {
        return [:]
    }

    public init() {
    }
}
