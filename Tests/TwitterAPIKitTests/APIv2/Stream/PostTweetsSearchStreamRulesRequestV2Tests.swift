import TwitterAPIKit
import XCTest

class PostTweetsSearchStreamRulesRequestV2Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test() throws {

        XCTContext.runActivity(named: "add") { _ in

            let add = PostTweetsSearchStreamRulesRequestV2(
                operation: .add([
                    .init(value: "value", tag: "tag"),
                    .init(value: "hoge"),
                ]))

            XCTAssertEqual(add.method, .post)
            XCTAssertEqual(add.path, "/2/tweets/search/stream/rules")
            XCTAssertEqual(add.bodyContentType, .json)

            AssertEqualAnyDict(add.parameters, [:])
            AssertEqualAnyDict(
                add.bodyParameters,
                [
                    "add": [
                        ["value": "value", "tag": "tag"],
                        ["value": "hoge"],
                    ]
                ])
            AssertEqualAnyDict(add.queryParameters, [:])
        }

        XCTContext.runActivity(named: "delete") { _ in

            let delete = PostTweetsSearchStreamRulesRequestV2(operation: .delete(["1", "20"]))

            XCTAssertEqual(delete.method, .post)
            XCTAssertEqual(delete.path, "/2/tweets/search/stream/rules")
            XCTAssertEqual(delete.bodyContentType, .json)

            AssertEqualAnyDict(delete.parameters, [:])
            AssertEqualAnyDict(
                delete.bodyParameters,
                [
                    "delete": [
                        "ids": ["1", "20"]
                    ]
                ])
            AssertEqualAnyDict(delete.queryParameters, [:])
        }
    }

    func testDryRun() throws {

        let add = PostTweetsSearchStreamRulesRequestV2(
            operation: .add([
                .init(value: "value", tag: "tag"),
                .init(value: "hoge"),
            ]), dryRun: true)

        XCTAssertEqual(add.method, .post)
        XCTAssertEqual(add.path, "/2/tweets/search/stream/rules")
        XCTAssertEqual(add.bodyContentType, .json)

        AssertEqualAnyDict(add.parameters, [:])
        AssertEqualAnyDict(
            add.bodyParameters,
            [
                "add": [
                    ["value": "value", "tag": "tag"],
                    ["value": "hoge"],
                ]
            ])

        AssertEqualAnyDict(add.queryParameters, ["dry_run": true])
    }

}
