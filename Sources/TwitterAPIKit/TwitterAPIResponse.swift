import Foundation

public typealias TwitterAPISuccessReponse = (data: Data, rateLimit: TwitterRateLimit, response: HTTPURLResponse)

public typealias TwitterAPISerializedSuccessResponse = (
    data: Any, rateLimit: TwitterRateLimit, response: HTTPURLResponse
)

public typealias TwitterAPIDecodedSuccessResponse<D: Decodable> = (
    data: D, rateLimit: TwitterRateLimit, response: HTTPURLResponse
)
