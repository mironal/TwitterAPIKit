import Foundation

extension String {
    var urlEncodedString: String {
        var allowedCharacterSet: CharacterSet = .urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\n:#/?@!$&'()*+,;=")
        allowedCharacterSet.insert(charactersIn: "[]")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)!
    }
}
