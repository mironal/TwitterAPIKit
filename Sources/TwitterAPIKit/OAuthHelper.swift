import CommonCrypto
import Foundation

private let oauthVersion = "1.0"
private let oauthSignatureMethod = "HMAC-SHA1"

func authorizationHeader(
    for method: HTTPMethod,
    url: URL,
    parameters: [String: Any],
    consumerKey: String,
    consumerSecret: String,
    oauthToken: String?,
    oauthTokenSecret: String?,
    oauthTimestamp: String? = .none,
    oauthNonce: String? = .none
) -> String {
    var authorizationParameters = [String: Any]()
    authorizationParameters["oauth_version"] = oauthVersion
    authorizationParameters["oauth_signature_method"] = oauthSignatureMethod
    authorizationParameters["oauth_consumer_key"] = consumerKey
    authorizationParameters["oauth_timestamp"] = oauthTimestamp ?? String(Int(Date().timeIntervalSince1970))
    authorizationParameters["oauth_nonce"] = oauthNonce ?? UUID().uuidString

    if let oauthToken = oauthToken {
        authorizationParameters["oauth_token"] = oauthToken
    }

    for (key, value) in parameters where key.hasPrefix("oauth_") {
        authorizationParameters.updateValue(value, forKey: key)
    }

    let combinedParameters = authorizationParameters.merging(parameters) { $1 }

    authorizationParameters["oauth_signature"] = oauthSignature(
        for: method, url: url, parameters: combinedParameters, consumerSecret: consumerSecret,
        oauthTokenSecret: oauthTokenSecret)

    let authorizationParameterComponents = authorizationParameters.urlEncodedQueryString.components(
        separatedBy: "&"
    ).sorted()

    var headerComponents = [String]()
    for component in authorizationParameterComponents {
        let subcomponent = component.components(separatedBy: "=")
        if subcomponent.count == 2 {
            headerComponents.append("\(subcomponent[0])=\"\(subcomponent[1])\"")
        }
    }

    return "OAuth " + headerComponents.joined(separator: ", ")
}

private func oauthSignature(
    for method: HTTPMethod,
    url: URL,
    parameters: [String: Any],
    consumerSecret: String,
    oauthTokenSecret: String?
) -> String {
    let tokenSecret = oauthTokenSecret?.urlEncodedString ?? ""
    let encodedConsumerSecret = consumerSecret.urlEncodedString
    let signingKey = "\(encodedConsumerSecret)&\(tokenSecret)"
    let parameterComponents = parameters.urlEncodedQueryString.components(separatedBy: "&").sorted()
    let parameterString = parameterComponents.joined(separator: "&")
    let encodedParameterString = parameterString.urlEncodedString
    let encodedURL = url.absoluteString.urlEncodedString
    let signatureBaseString = "\(method.rawValue)&\(encodedURL)&\(encodedParameterString)"

    let key = signingKey.data(using: .utf8)!
    let msg = signatureBaseString.data(using: .utf8)!
    let sha1 = msg.hmac(key: key)
    return sha1.base64EncodedString(options: [])
}
