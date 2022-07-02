public typealias TwitterAuthAPI =
    TwitterAuthAPIResource
    & OAuth10aAPI
    & OAuth20API

public protocol TwitterAuthAPIResource {
    var oauth10a: OAuth10aAPI { get }
    var oauth20: OAuth20API { get }
}

extension TwitterAPIClient.TwitterAuthAPIImpl: TwitterAuthAPIResource {
    var oauth10a: OAuth10aAPI { return self }
    var oauth20: OAuth20API { return self }
}
