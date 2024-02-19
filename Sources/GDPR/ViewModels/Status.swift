import Foundation

struct Status: Codable {
    var latestPolicyChange: Date?
    var lastAcceptedPrivacy: TermState
    var services: [ServiceModel]
}

public enum TermState: Codable {
    case accepted(date: Date)
    case rejected
    case undefined

    enum CodingKeys: String, CodingKey {
        case accepted
        case rejected
        case undefined
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(Date.self, forKey: .accepted) {
            self = .accepted(date: value)
        } else if (try? values.decode(String.self, forKey: .rejected)) != nil {
            self = .rejected
        } else {
            self = .undefined
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .accepted(let date):
            try container.encode(date, forKey: .accepted)
        case .rejected:
            try container.encode("notAccepted", forKey: .rejected)
        case .undefined:
            try container.encode("undefined", forKey: .undefined)
        }
    }
}
