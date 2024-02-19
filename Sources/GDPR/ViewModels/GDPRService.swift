import Foundation

public struct GDPRService {
    let id: String
    let name: String
    let description: String
    let supportDeletion: Bool

    public init(id: String, name: String, description: String, supportDeletion: Bool = false) {
        self.id = id
        self.name = name
        self.supportDeletion = supportDeletion
        self.description = description
    }
}
