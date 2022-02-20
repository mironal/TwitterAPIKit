import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"

    public var prefersQueryParameters: Bool {
        switch self {
        case .get, .delete:
            return true
        default:
            return false
        }
    }
}

public enum BodyContentType: String {
    case wwwFormUrlEncoded = "application/x-www-form-urlencoded"

    /// In this case use MultipartFormDataPart as a parameter
    /// example: UploadMediaAppendRequestV1.swift
    case multipartFormData = "multipart/form-data"
    case json = "application/json"
}

public enum MultipartFormDataPart {
    case value(name: String, value: Any)  // value is stringified with "String(describing:)"
    case data(name: String, value: Data, filename: String, mimeType: String)
}

public protocol TwitterAPIRequest {
    var method: HTTPMethod { get }
    var baseURLType: TwitterBaseURLType { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    var bodyContentType: BodyContentType { get }
}

extension TwitterAPIRequest {
    public var baseURLType: TwitterBaseURLType {
        return .api
    }

    public var bodyContentType: BodyContentType {
        return .wwwFormUrlEncoded
    }
}
