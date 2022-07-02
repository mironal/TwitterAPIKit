open class TwitterAuthAPI: TwitterAPIBase {

    public let oauth10a: OAuth10aAPI
    public var oauth20: OAuth20API

    public override init(session: TwitterAPISession) {
        oauth10a = .init(session: session)
        oauth20 = .init(session: session)

        super.init(session: session)
    }
}
