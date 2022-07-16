# How to decode API response

The API response format differs significantly between version 1 and version 2.

TwitterAPIKit has a method (`responseDecodable`) that takes a Decodable as an argument but does not provide a Decodable-compliant response "type".

The reason for not providing a "type" is that Twitter responses are so large that parsing and using all of them would be wasteful, and we believe that users should define their own "types" as needed.

In the following, we describe how to decode responses using `responseDecodable`.

## The Date

The Date format included in the response of the version 1 and version 2 APIs is different.

- v1: `Sun Jul 03 04:32:05 +0000 2022`
- v2: `2022-07-03T04:32:05.000Z`

However, you don't need to worry about it because TwitterAPIKit can correctly parse both formats.

## The V1 API response

It is easy and not particularly difficult.

```swift
// Example

// Define the "Decodable"

struct TwitterUserV1: Decodable {
    var id: String
    var name: String
    var screenName: String
    var createdAt: Date
    var statusesCount: Int

    enum CodingKeys: String, CodingKey {
        case id = "idStr"
        case name
        case screenName
        case createdAt
        case statusesCount
    }
}

struct TwitterStatusV1: Decodable {
    var id: String
    var text: String
    var createdAt: Date
    var user: TwitterUserV1

    enum CodingKeys: String, CodingKey {
        case id = "idStr"
        case text
        case createdAt
        case user
    }
}

// Get home timeline

func request() async throws {
    let response = await client.v1 .getHomeTimeline(.init()).responseDecodable(type: [TwitterStatusV1].self)
    if let error = response.error {
        print(error)
        throw error
    } else {
        print(response.success!)
    }
}
```

## The V2 API response

The v2 response is somewhat unique in format and requires some ingenuity.

> https://developer.twitter.com/en/docs/twitter-api/migrate/data-formats

Usually, v2 responses will contain only minimal information in `data`.

If you request additional information using the `fields` or `expansions` parameters, additional information will be included in the `includes` as shown below.

Some endpoints may also include `meta`.

```json
{
  "data": [
    {
      "author_id": "2244994945",
      "id": "1397568983931392004",
      "text": "The Twitter Developer Platform. Ooh la la! https://t.co/iGTdPXBfOv https://t.co/Ze8z8EODdg"
    }
  ],
  "includes": {
    "users": [
      {
        "id": "2244994945",
        "name": "Twitter Dev",
        "username": "TwitterDev"
      }
    ]
  },
  "meta": {
    "newest_id": "1280169177479744444",
    "oldest_id": "1279945722494811111",
    "result_count": 4
  }
}
```

If there is a problem with your request parameters, `errors` will be included in the response as follows.

```json
{
  "errors": [
    {
      "resource_type": "tweet",
      "title": "Field Authorization Error",
      "section": "data",
      "detail": "Sorry, you are not authorized to access non_public_metrics.user_profile_clicks on a Tweet.",
      "field": "non_public_metrics.user_profile_clicks",
      "type": "https://api.twitter.com/2/problems/not-authorized-for-field"
    }
  ]
}
```

### How Decode?

This section describes how to decode them.

```swift
// 1. First, define a structure (or class) to wrap the actual resource (Tweet or User).
//    Using generics allows for "Swifty" expressions.
public struct TwitterDataResponseV2<DataType: Decodable, Includes: Decodable, Meta: Decodable>: Decodable {
    public var data: DataType
    public var includes: Includes?
    public var meta: Meta?

    // You can also define errors if you need to.
    // In that case, `data` is optional.
    // You should also implement `TwitterV2Error` if you need it.
    // ↓↓↓
    // public var errors: [TwitterV2Error]
}

// 2. Next, define the structure (or class) of the required resource.
//    In this example, we define Tweet and User to retrieve the timeline.
struct TwitterUserV2: Decodable {
    struct PublicMetrics: Decodable {
        let tweetCount: Int
    }

    var id: String
    var name: String
    var username: String
    var createdAt: Date
    var publicMetrics: PublicMetrics
}

struct TwitterStatusV2: Decodable {

    struct Include: Decodable {
        var users: [TwitterUserV2]
    }

    struct Meta: Decodable {
        var resultCount: Int
    }

    var id: String
    var text: String
    var createdAt: Date
}

// Get home timeline
func request() async throws {
    let response = await client.v2.timeline.getUserReverseChronological(.init(
        id: "739766546",
        expansions: TwitterTweetExpansionsV2.all,
        mediaFields: TwitterMediaFieldsV2.all,
        tweetFields: TwitterTweetFieldsV2.all.subtracting([.promotedMetrics, .nonPublicMetrics, .organicMetrics]),
        userFields: TwitterUserFieldsV2.all)
    )
        .responseDecodable(type: TwitterDataResponseV2<[TwitterStatusV2], TwitterStatusV2.Include, TwitterStatusV2.Meta>.self)

    if let error = response.error {
        print(error)
        throw error
    } else {
        print(response.success!)
    }
}
```
