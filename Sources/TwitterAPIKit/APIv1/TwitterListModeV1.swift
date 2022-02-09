import Foundation

public enum TwitterListModeV1 {
    case `public`
    case `private`
}

extension TwitterListModeV1 {
    func bind(param: inout [String: Any]) {
        switch self {
        case .public:
            param["mode"] = "public"
        case .private:
            param["mode"] = "private"
        }
    }
}
