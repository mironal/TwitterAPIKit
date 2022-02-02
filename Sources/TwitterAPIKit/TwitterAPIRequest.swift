import Foundation

public protocol TwitterAPIRequest {

    func response(
        completionHandler: @escaping (Result<Data, TwitterAPIKitError>, HTTPURLResponse) -> Void)
}
