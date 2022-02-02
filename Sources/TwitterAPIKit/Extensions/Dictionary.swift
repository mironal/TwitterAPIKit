import Foundation

extension Dictionary {

    var urlEncodedQueryString: String {
        var parts = [String]()

        for (key, value) in self {
            let keyString = "\(key)".urlEncodedString
            let valueString = "\(value)".urlEncodedString
            let query: String = "\(keyString)=\(valueString)"
            parts.append(query)
        }

        return parts.joined(separator: "&")
    }
}
