import Foundation

extension String {
    var urlEncodedString: String {
        let allowedCharacterSet = NSMutableCharacterSet.alphanumeric()
        allowedCharacterSet.addCharacters(in: "-._~")
        return addingPercentEncoding(withAllowedCharacters: allowedCharacterSet as CharacterSet)!
    }
}
