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

## TODO

- [ ] Support API v1 endpoint
- [ ] Support API v2 endpoint
- [ ] Codable
- [ ] Swift Concurrency
- [ ] Document
