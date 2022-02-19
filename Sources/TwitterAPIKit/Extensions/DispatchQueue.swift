import Foundation

extension DispatchQueue {
    static var processQueue: DispatchQueue {
        return .global(qos: .default)
    }
}
