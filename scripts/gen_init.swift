import Foundation

/*
 public let target: TwitterUserIdentifier
 public let count: Int?

 ↓

 public init(
    target: TwitterUserIdentifier,
    count: Int? = none
 ) {
    self.target = target
    self.count = count
 }
 */

func exec() {
    let input = FileHandle.standardInput

    guard let input = String(bytes: input.availableData, encoding: .utf8) else {
        print("pbpaste | ./gen_params.swift")
        return
    }

    let regex = try! NSRegularExpression(pattern: #"[^ ] ([a-zA-Z]+): ([a-zA-Z\d]+\??)$"#)

    let pairs = input.split(separator: "\n")
        .map { line -> String in line.trimmingCharacters(in: .whitespacesAndNewlines) }
        .compactMap { line -> (name: String, type: String)? in
            guard let match = regex.firstMatch(in: line, options: [], range: .init(location: 0, length: line.count))
            else {
                return nil
            }
            guard match.numberOfRanges == 3 else {
                return nil
            }

            let firstRange: Range = Range(match.range(at: 1), in: line)!
            let secondRange: Range = Range(match.range(at: 2), in: line)!
            let name = String(line[firstRange])
            let type = String(line[secondRange])
            return (name: name, type: type)
        }

    let initArgs: [String] = pairs.map { (name: String, type: String) in
        if type.hasSuffix("?") {
            return "\(name): \(type) = .none"
        }
        return "\(name): \(type)"
    }

    let initBody: [String] = pairs.map { (name: String, type: String) in
        return "self.\(name) = \(name)"
    }

    let body = """
        public init(
            \(initArgs.joined(separator: ",\n    "))
        ) {
            \(initBody.joined(separator: "\n    "))
        }
        """

    print(body)
}

exec()
