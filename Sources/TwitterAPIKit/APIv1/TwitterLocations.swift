import Foundation

public struct TwitterCoordinateV1 {
    var lat: Double
    var long: Double

    public init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }

    func bind(param: inout [String: Any]) {
        param["lat"] = lat
        param["long"] = long
    }
}

public enum TwitterAccuracyV1 {
    /// meter
    case m(Int)
    /// feet
    case ft(Int)

    func bind(param: inout [String: Any]) {
        switch self {
        case .m(let int):
            param["accuracy"] = "\(int)m"
        case .ft(let int):
            param["accuracy"] = "\(int)ft"
        }
    }
}

public enum TwitterGranularityV1: String {
    case neighborhood
    case city
    case admin
    case country

    func bind(param: inout [String: Any]) {
        param["granularity"] = rawValue
    }
}
