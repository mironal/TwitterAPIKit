import XCTest

@testable import TwitterAPIKit

class ResultTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testSerialize() throws {
        let result: Result<Data, TwitterAPIKitError> = .success(Data())

        let serialized = result.serialize()
        XCTAssertTrue(serialized.error!.isResponseSerializeFailed)
    }

    func testDecode() throws {
        let result: Result<Data, TwitterAPIKitError> = .success(Data())

        let decoded = result.decode(DecodableObj.self, decodar: JSONDecoder())
        XCTAssertTrue(decoded.error!.isResponseSerializeFailed)
    }
}
