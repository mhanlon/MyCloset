import SwiftUI

class MyCloset: ObservableObject {
    @Published var clothingItems: [ClothingItem] = [
        ClothingItem(name: "Red Shirt", size: "M", isFavorite: true),
        ClothingItem(name: "Black Jeans", size: "32", isFavorite: false),
    ]
}
