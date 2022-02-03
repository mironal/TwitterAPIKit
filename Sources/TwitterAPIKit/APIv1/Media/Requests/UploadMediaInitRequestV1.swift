import Foundation

open class UploadMediaInitRequestV1: TwitterAPIRequest {

    // TODO

    public var method: HTTPMethod {
        return .post
    }

    public var baseURLType: TwitterBaseURLType {
        return .upload
    }

    public var path: String {
        return ""
    }

    open var parameters: [String: Any]? {
        return [:]
    }
}
