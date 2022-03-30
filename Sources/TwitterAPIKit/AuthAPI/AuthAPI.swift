public typealias TwitterAuthAPI =
    TwitterAuthAPIResource
    & OAuth11aAPI
    & OAuth20API

public protocol TwitterAuthAPIResource {
    var oauth11a: OAuth11aAPI { get }
    var oauth20: OAuth20API { get }
}

extension TwitterAPIKit.TwitterAuthAPIImpl: TwitterAuthAPIResource {
    var oauth11a: OAuth11aAPI { return self }
    var oauth20: OAuth20API { return self }
}
