# TwitterAPIKit

Swift library for the Twitter API v1 and v2 (Work in progress).

---

Unfortunately, I couldn't find any active Twitter API library for Swift at the moment.

So, I decided to create one.

## Policy

- No dependencies

## Example

```swift
    let consumerKey = ""
    let consumerSecret = ""
    let oauthToken = ""
    let oauthTokenSecret = ""

    let client = TwitterAPIKit(
        consumerKey: consumerKey,
        consumerSecret: consumerSecret,
        oauthToken: oauthToken,
        oauthTokenSecret: oauthTokenSecret
    )

    client.v1.getShowStatus(.init(id: "status id")) { result in

        switch result {
        case let .success((data, rateLimit, httpURLResponse)):
            print("--- Success ---")
            print("Rate Limit", rateLimit)

            // parse json
            let obj = JSONSerialization.jsonObject(with: data, options: [])

            // Or decode
            let decoder = JSONDecoder()
            let product = try decoder.decode(YourModel.self, from: data)

        case .failure(let error): // TwitterAPIKitError
            print("--- Error ---")
            if let data = error.data {
                print("Body:", String(data: data, encoding: .utf8)!)
            }
            if let rateLimit = error.rateLimit {
                print("Rate Limit", rateLimit)
            }
        }
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

```
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

    class YourCustomRequest: {
        // write code...
    }


    let consumerKey = ""
    let consumerSecret = ""
    let oauthToken = ""
    let oauthTokenSecret = ""

    let client = TwitterAPIKit(
        consumerKey: consumerKey,
        consumerSecret: consumerSecret,
        oauthToken: oauthToken,
        oauthTokenSecret: oauthTokenSecret
    )
    
    let request = YourCustomRequest()
    client.session.send(request) { result in
        // ...
    }
}
```

## TODO

- [ ] Support API v1 endpoint
- [ ] Support API v2 endpoint
- [ ] Swift Concurrency
- [ ] Document
