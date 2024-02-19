import SwiftUI

struct ClothingItemRowView: View {
    /*#-code-walkthrough(2.property)*/
    let clothingItem: ClothingItem
    /*#-code-walkthrough(2.property)*/

    var body: some View {
        VStack(alignment: .leading) {
            /*#-code-walkthrough(2.rowview)*/
            HStack {
                Text(clothingItem.name)
                Spacer()
                Image(systemName: clothingItem.isFavorite ? "heart.fill": "heart")
                    .foregroundColor(clothingItem.isFavorite ? .pink : .gray)
            }
            .font(.title2)
            .fontWidth(.compressed)
            Text("Size: \(clothingItem.size)")
        }
        .padding()
        .background(Color.teal.opacity(0.3))
        .cornerRadius(12.0)
        .padding(.horizontal)
        /*#-code-walkthrough(2.rowview)*/
    }
}

#Preview {
    ClothingItemRowView(clothingItem: ClothingItem(name: "Pink Shirt", size: "S", isFavorite: false))
}
