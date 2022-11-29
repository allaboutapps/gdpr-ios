import Foundation

extension Sequence where Element: Hashable {
    var hasDuplicates: Bool {
        var elements = Set<Element>()
        for element in self {
            guard !elements.contains(element) else { return true }
            elements.insert(element)
        }
        return false
    }
}
