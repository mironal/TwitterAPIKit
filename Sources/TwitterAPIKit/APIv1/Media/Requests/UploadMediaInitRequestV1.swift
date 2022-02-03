import Foundation

public class UploadMediaInitRequestV1: TwitterAPIRequest {

    public var method: HTTPMethod {
        return .post
    }

    public var baseURLType: TwitterBaseURLType {
        return .upload
    }

    public var path: String {
        return ""
    }

    public var parameters: [String: Any]? {
        return [:]
    }
}
