import Foundation

class MockURLProtocol: URLProtocol {

    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    static var requestAssert: ((URLRequest) throws -> Void)?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    static func cleanup() {
        MockURLProtocol.requestHandler = nil
        MockURLProtocol.requestAssert = nil
    }

    override func startLoading() {

        let handler: ((URLRequest) throws -> (HTTPURLResponse, Data?))
        if let h = MockURLProtocol.requestHandler {
            handler = h
        } else {
            handler = { request in
                return (
                    HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!, Data()
                )
            }
        }

        do {

            try MockURLProtocol.requestAssert?(request)

            let (response, data): (URLResponse, Data?) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }

            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {

    }
}
