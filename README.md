# TwitterAPIKit

Swift library for the Twitter API v1 and v2.

[![Swift](https://github.com/mironal/TwitterAPIKit/actions/workflows/swift.yml/badge.svg)](https://github.com/mironal/TwitterAPIKit/actions/workflows/swift.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmironal%2FTwitterAPIKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/mironal/TwitterAPIKit) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmironal%2FTwitterAPIKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/mironal/TwitterAPIKit)
[![Standard](https://img.shields.io/endpoint?url=https%3A%2F%2Ftwbadges.glitch.me%2Fbadges%2Fstandard)](https://developer.twitter.com/en/docs/twitter-api) [![v2](https://img.shields.io/endpoint?url=https%3A%2F%2Ftwbadges.glitch.me%2Fbadges%2Fv2)](https://developer.twitter.com/en/docs/twitter-api)
[![codecov](https://codecov.io/gh/mironal/TwitterAPIKit/branch/main/graph/badge.svg?token=T2H3D6ASA0)](https://codecov.io/gh/mironal/TwitterAPIKit)

Please see this issue for the progress of the API implementation.

- [API v1](https://github.com/mironal/TwitterAPIKit/issues/5)
- [API v2](https://github.com/mironal/TwitterAPIKit/issues/6)

Issue やコメントは日本語でも大丈夫です。

---

## Motivation

Unfortunately, I couldn't find any active Twitter API library for Swift at the moment.

So, I decided to create one.

## Policy

- No dependencies

## API Structures

You can limit the scope of available APIs depending on your application.
This is useful if your app only supports v1, or if you want to limit access to the API.
Currently, scoping according to Twitter's App permissions is not yet implemented.

```swift

// The most common usage.

// For OAuth 1.0a
let client = TwitterAPIClient(.oauth10a(.init(
            consumerKey: "",
            consumerSecret: "",
            oauthToken: "",
            oauthTokenSecret: ""
        )))
// For OAuth 2.0 client
let client = TwitterAPIClient(.oauth20(.init(
            clientID: "",
            scope: [],
            tokenType: "",
            expiresIn: 0,
            accessToken: "",
            refreshToken: ""
        )))

client.v1.someV1API()
client.v2.someV2API()

// V1 only client
let v1Client = client.v1
v1Client.someV1API()

// V2 only client
let v2Client = client.v2
v2Client.someV2API()

// DM only client
let dmClient = client.v1.directMessage
dmClient.someDM_APIs()

// Each API can be accessed flatly or by individual resource.

// Flat.
let client.v1.allV1_APIs()

// Individual resources.
let client.v1.tweet.someTweetAPIs()
let client.v1.directMessage.someDM_APIs()
```

## How do I authenticate?

[Please see "HowDoIAuthenticate.md"](./HowDoIAuthenticate.md)

And the following sample project includes a sample authentication.

> https://github.com/mironal/TwitterAPIKit-iOS-sample

## How to decode response

[Please see "HowToDecodeResponse.md"](./HowToDecodeResponse.md)

## Example

### Projects

- https://github.com/mironal/TwitterAPIKit-iOS-sample

This sample project contains examples of how to authenticate with `OAuth 1.0a User Access Tokens (3-legged OAuth flow)` and `OAuth 2.0 Authorization Code Flow with PKCE`.

### Basic

```swift
    let consumerKey = ""
    let consumerSecret = ""
    let oauthToken = ""
    let oauthTokenSecret = ""

    let client = TwitterAPIClient(
        consumerKey: consumerKey,
        consumerSecret: consumerSecret,
        oauthToken: oauthToken,
        oauthTokenSecret: oauthTokenSecret
    )

    client.v1.getShowStatus(.init(id: "status id"))
         // Already serialized using "JSONSerialization.jsonObject(with:, options:)".
        .responseObject() { response in }
        .responseObject(queue: .global(qos: .default)) { response in  }

        // Already decoded using JSONDecoder.
        .responseDecodable(type: Entity.self, queue: .global(qos: .default)) { response in }
        .responseDecodable(type: Entity.self) { response in }

        // Unprocessed data
        .responseData() { response in /* Run in .main queue */ }
        .responseData((queue: .global(qos: .default)) { response in /* Run in .global(qos: .default) queue  */ }

        // !! A `prettyString` is provided for debugging purposes. !!
        print(response.prettyString)

        result.map((Success) -> NewSuccess)
        result.tryMap((Success) throws -> NewSuccess)
        result.mapError((TwitterAPIKitError) -> TwitterAPIKitError>)
        result.success // Success?
        result.error // TwitterAPIKitError?
        response.rateLimit

        // Use result
        do {
            let success = try response.result.get()
            print(success)
        } catch let error {
            print(error)
        }
    }
```

### Refresh OAuth 2.0 Token

```swift
let refresh = try await client.refreshOAuth20Token(type: .confidentialClient(clientID: "", clientSecret: ""), forceRefresh: true)
// let refresh = try await client.refreshOAuth20Token(type: .publicClient, forceRefresh: true)

// The authentication information in the Client is also updated, so there is no need to recreate a new instance of the Client.

if refresh.refreshed {
    storeToken(refresh.token)
}

// Or

client.refreshOAuth20Token(type: .publicClient, forceRefresh: true) { result in
    do {
        let refresh = try result.get()
        if refresh.refreshed {
            storeToken(refresh.token)
        }
    } catch {

    }
}

// Notification

NotificationCenter.default.addObserver(
    self,
    selector: #selector(didRefreshOAuth20Token(_:)),
    name: TwitterAPIClient.didRefreshOAuth20Token,
    object: nil
)

@objc func didRefreshOAuth20Token(_ notification: Notification) {
    guard let token = notification.userInfo?[TwitterAPIClient.tokenUserInfoKey] as? TwitterAuthenticationMethod.OAuth20 else {
        fatalError()
    }
    print("didRefreshOAuth20Token", didRefreshOAuth20Token, token)
    store(token)
}
```

### Custom Request class

The class of each request can be inherited to create subclasses. This is why it is declared as an open class instead of a struct.

This is intended so that when new parameters are added due to changes in the Twitter API, you can handle them yourself without waiting for the library to be updated.

```swift
// example
class CustomListsListRequestV1: GetListsListRequestV1 {

    let custom: String

    override var parameters: [String: Any] {
        var p = super.parameters
        p["custom"] = custom
        return p
    }

    init(custom: String, user: TwitterUserIdentifierV1, reverse: Bool? = .none) {
        self.custom = custom
        super.init(user: user, reverse: reverse)
    }
}
```

It is also possible to create an encapsulated custom request class.

```swift
class CapsuledListsListRequestV1: GetListsListRequestV1 {
    init() {
        super.init(user: .userID("100"), reverse: true)
    }
}
```

### Low level api

This method is intended to be used when the library does not yet support Twitter's new API.

- You can customize the request yourself.
- You can use `session.send(TwitterAPIRequest,completionHandler:)` to send the request.

```swift

    class YourCustomRequest: TwitterAPIRequest {
        // write code...
    }


    let consumerKey = ""
    let consumerSecret = ""
    let oauthToken = ""
    let oauthTokenSecret = ""

    let client = TwitterAPIClient(
        consumerKey: consumerKey,
        consumerSecret: consumerSecret,
        oauthToken: oauthToken,
        oauthTokenSecret: oauthTokenSecret
    )

    let request = YourCustomRequest()
    client.session.send(request)
}
```

### Swift Concurrency (experimental)

```swift
Task {
    let result = try await client.v1.timeline.getHomeTimeline(.init()).responseData // or responseObject or response responseDecodable(type: Hoge.self)

    print(result.prettyString)
}
```

### Stream API

- [Sample code for GET /2/tweets/sample/stream](https://gist.github.com/mironal/bd511a211f6a300b32350b83350894eb)
- [Sample code for GET /2/tweets/search/stream](https://gist.github.com/mironal/6ad38705ad729c71afec9816abccbfd4)

## TODO

- [ ] Support API v1 endpoint : 85% completed (Commonly used APIs are 100% supported.)
- [x] Support API v2 endpoint: 100% completed (Except for Lab)
- [x] Swift Concurrency (Experimental)
- [ ] Document
