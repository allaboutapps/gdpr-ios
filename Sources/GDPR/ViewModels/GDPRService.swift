import Foundation

public struct GDPRService {
    var id: String
    var name: String
    var description: String
    var supportDeletion: Bool?

    public init(id: String, name: String, description: String, supportDeletion: Bool = false) {
        self.id = id
        self.name = name
        self.supportDeletion = supportDeletion
        self.description = description
    }
}
