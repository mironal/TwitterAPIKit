import TwitterAPIKit
import XCTest

class MultipartFormDataPartTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testEqualValue() throws {

        let a = MultipartFormDataPart.value(name: "n", value: 1)
        let b = MultipartFormDataPart.value(name: "n", value: "1")
        let c = MultipartFormDataPart.value(name: "n", value: Float(1))
        let d = MultipartFormDataPart.value(name: "m", value: 1)

        [a, b, c, d].combinations(ofCount: 2).forEach { combo in
            XCTAssertNotEqual(combo[0], combo[1])
        }
    }

    func testEqualData() throws {
        let data = Data()
        let a = MultipartFormDataPart.data(name: "n", value: data, filename: "f", mimeType: "m")
        let b = MultipartFormDataPart.data(name: "m", value: data, filename: "f", mimeType: "m")
        let c = MultipartFormDataPart.data(name: "n", value: data, filename: "ff", mimeType: "m")
        let d = MultipartFormDataPart.data(name: "n", value: data, filename: "f", mimeType: "mm")
        let e = MultipartFormDataPart.data(name: "n", value: Data(repeating: 1, count: 1), filename: "f", mimeType: "m")
        let f = MultipartFormDataPart.value(name: "n", value: data)

        let a1 = MultipartFormDataPart.data(name: "n", value: Data(), filename: "f", mimeType: "m")

        [a, b, c, d, e, f].combinations(ofCount: 2).forEach { combo in
            XCTAssertNotEqual(combo[0], combo[1])
        }

        XCTAssertEqual(a, a1)
    }
}
