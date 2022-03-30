import Foundation

/* ex
 confidential client
 {
    "scope" : "tweet.write tweet.read",
    "token_type" : "bearer",
    "expires_in" : 7200,
    "access_token" : "<token>"
 }

 public client
 {
    "refresh_token" : "<refresh token>",
    "scope" : "tweet.write tweet.read offline.access",
    "token_type" : "bearer",
    "expires_in" : 7200,
    "access_token" : "<token>"
 }
 */

public struct TwitterOAuth2AccessToken {

    public let scope: [String]
    public let tokenType: String
    public let expiresIn: Int
    public let accessToken: String

    /// Only Public Client
    public let refreshToken: String?

    public init?(jsonData: Data) throws {
        let json = try JSONSerialization.jsonObject(with: jsonData, options: [])

        guard let obj = json as? [String: Any],
            let scope = obj["scope"] as? String,
            let tokenType = obj["token_type"] as? String,
            let expiresIn = obj["expires_in"] as? Int,
            let accessToken = obj["access_token"] as? String
        else { return nil }

        self.scope = scope.components(separatedBy: " ")
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.accessToken = accessToken
        self.refreshToken = obj["refresh_token"] as? String
    }
}

extension TwitterOAuth2AccessToken {
    static func fromResponse(data: Data) throws -> Self {
        do {
            guard let token = try TwitterOAuth2AccessToken(jsonData: data) else {
                throw TwitterAPIKitError.responseSerializeFailed(
                    reason: .cannotConvert(data: data, toTypeName: "TwitterOAuth2AccessToken")
                )
            }
            return token
        } catch let error {
            throw TwitterAPIKitError.responseSerializeFailed(
                reason: .jsonSerializationFailed(error: error)
            )
        }
    }
}
