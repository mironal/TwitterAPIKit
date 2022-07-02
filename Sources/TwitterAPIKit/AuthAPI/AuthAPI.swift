open class TwitterAuthAPI {

    public let oauth10a: OAuth10aAPI
    public let oauth20: OAuth20API

    public init(session: TwitterAPISession) {
        oauth10a = .init(session: session)
        oauth20 = .init(session: session)
    }
}
