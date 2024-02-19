import Foundation

class ServiceModel: Codable, ObservableObject {
    var id: String
    var name: String
    var description: String
    
    @Published var isOptIn: Bool {
        didSet {
            GDPRManager.shared.delegate?.serviceValueDidChange(serviceId: id, isEnabled: isOptIn)
            PersistenceManager.shared.saveStatus(status: GDPRManager.shared.currentStatus!)
        }
    }

    var supportDeletion: Bool

    init(id: String, name: String, description: String, supportDeletion: Bool, isOptIn: Bool) {
        self.id = id
        self.name = name
        self.isOptIn = isOptIn
        self.supportDeletion = supportDeletion
        self.description = description
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isOptIn = try container.decode(Bool.self, forKey: .isOptIn)
        id = try container.decode(String.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
        name = try container.decode(String.self, forKey: .name)
        supportDeletion = try container.decode(Bool.self, forKey: .supportDeletion)
    }

    enum CodingKeys: CodingKey {
        case isOptIn
        case id
        case name
        case description
        case supportDeletion
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isOptIn, forKey: .isOptIn)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
        try container.encode(supportDeletion, forKey: .supportDeletion)
    }

    func delete() {
        isOptIn = false
        GDPRManager.shared.delegate?.deleteData(serviceId: id)
    }
}
