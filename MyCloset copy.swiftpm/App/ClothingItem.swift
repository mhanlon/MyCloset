import Foundation

struct ClothingItem : Identifiable {
    let id = UUID()
    var name: String
    var size: String
    var isFavorite: Bool
}
