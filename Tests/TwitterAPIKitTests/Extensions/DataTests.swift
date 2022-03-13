import XCTest

@testable import TwitterAPIKit

class DataTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testSerialize() throws {
        XCTContext.runActivity(named: "success") { _ in
            let data = Data("{\"a\":1}".utf8)
            let serialized = data.serialize()
            XCTAssertEqual(serialized.success as! [String: Int], ["a": 1])
        }

        XCTContext.runActivity(named: "failure") { _ in
            let data = Data()
            let serialized = data.serialize()
            XCTAssertTrue(serialized.error!.isResponseSerializeFailed)
        }
    }

    func testDecode() throws {
        struct Obj: Decodable {
            let a: Int
        }
        XCTContext.runActivity(named: "success") { _ in
            let data = Data("{\"a\":1}".utf8)
            let serialized = data.decode(Obj.self, decoder: JSONDecoder())
            XCTAssertEqual(serialized.success?.a, 1)
        }

        XCTContext.runActivity(named: "failure") { _ in
            let data = Data()
            let serialized = data.decode(Obj.self, decoder: JSONDecoder())
            XCTAssertTrue(serialized.error!.isResponseSerializeFailed)
        }
    }
}
