import Foundation

public protocol HelpAPIv1 {

    /// https://developer.twitter.com/en/docs/twitter-api/v1/developer-utilities/supported-languages/api-reference/get-help-languages
    @discardableResult
    func getSupportedLanguages(
        _ request: GetHelpLanguagesRequestV1
    ) -> TwitterAPISessionTask
}

extension TwitterAPIKit.TwitterAPIImplV1: HelpAPIv1 {
    func getSupportedLanguages(
        _ request: GetHelpLanguagesRequestV1
    ) -> TwitterAPISessionTask {
        return session.send(request)
    }
}
