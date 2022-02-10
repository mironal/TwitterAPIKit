import Foundation
import XCTest

// swift-format-ignore: AlwaysUseLowerCamelCase
func AssertEqualAnyDict(
    _ l: [String: Any], _ r: [String: Any], _ message: @autoclosure () -> String = "", file: StaticString = #filePath,
    line: UInt = #line
) {
    // It works well most of the time.
    XCTAssertEqual(NSDictionary(dictionary: l), NSDictionary(dictionary: r), message(), file: file, line: line)
}
