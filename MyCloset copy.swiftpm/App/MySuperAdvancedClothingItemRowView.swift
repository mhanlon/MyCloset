import SwiftUI

struct MySuperAdvancedClothingItemRowView: View {
    /*#-code-walkthrough(4.bindingproperty)*/
    @Binding var clothingItem: ClothingItem
    /*#-code-walkthrough(4.bindingproperty)*/

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(clothingItem.name)
                Spacer()
                /*#-code-walkthrough(4.bindingbutton)*/
                Button {
                    clothingItem.isFavorite.toggle()
                } label: {
                    Image(systemName: clothingItem.isFavorite ? "heart.fill": "heart")
                        .foregroundColor(clothingItem.isFavorite ? .pink : .gray)
                }
                /*#-code-walkthrough(4.bindingbutton)*/
            }
            .font(.title2)
            .fontWidth(.compressed)
            Text("Size: \(clothingItem.size)")
        }
        .padding()
        .background(Color.teal.opacity(0.3))
        .cornerRadius(12.0)
        .padding(.horizontal)
    }
}

#Preview {
    MySuperAdvancedClothingItemRowView(clothingItem: .constant(ClothingItem(name: "Pink Shirt", size: "S", isFavorite: false)))
}
