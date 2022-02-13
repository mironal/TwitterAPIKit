import Foundation

private let formatter = ISO8601DateFormatter()
extension Date {
    func toISO8601String() -> String {
        return formatter.string(from: self)
    }

    func bind(param: inout [String: Any], for key: String) {
        param[key] = toISO8601String()
    }
}
