import SwiftUI

struct ContentView: View {
    /*#-code-walkthrough(1.intro)*/
    let clothingItems: [ClothingItem] = [
        ClothingItem(name: "Red Shirt", size: "M", isFavorite: true),
        ClothingItem(name: "Black Jeans", size: "32", isFavorite: false),
    ]
    /*#-code-walkthrough(1.intro)*/

    var body: some View {
        ScrollView {
            Text("My closet")
                .font(.title)
                .fontWidth(.compressed)
                .padding()
            /*#-code-walkthrough(1.foreach)*/
            ForEach(clothingItems) { item in
                VStack(alignment: .leading) {
                    HStack {
                        Text(item.name)
                        Spacer()
                        Image(systemName:item.isFavorite ? "heart.fill": "heart")
                            .foregroundColor(item.isFavorite ? .pink : .gray)
                    }
                    .font(.title2)
                    .fontWidth(.compressed)
                    Text("Size: \(item.size)")
                }
                .padding()
                .background(Color.teal.opacity(0.3))
                .cornerRadius(12.0)
                .padding(.horizontal)
            }
            /*#-code-walkthrough(1.foreach)*/
        }
    }
}
