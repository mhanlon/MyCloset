import SwiftUI

struct MyClosetView: View {
    let clothingItems: [ClothingItem] = [
        ClothingItem(name: "Red Shirt", size: "M", isFavorite: true),
        ClothingItem(name: "Black Jeans", size: "32", isFavorite: false),
    ]
    

    var body: some View {
        VStack {
            Text("My closet")
                .font(.title)
                .fontWidth(.compressed)
                .padding()
            /// Try out your closet listing as a List by un-commenting the line below and commenting out the lines that start with ForEach(clothingItems)... and ScrollView
            /// You'll note that you need to comment out the brace below, as well (see the comment down there)!
            /// And if you un-comment the .listStyle(.plain) and .listRowSeparator lines you'll hardly know the difference between the two!
            //List(clothingItems) { item in
            ScrollView {
                ForEach(clothingItems) { item in
                    /*#-code-walkthrough(2.customrow)*/
                    ClothingItemRowView(clothingItem: item)
                    /*#-code-walkthrough(2.customrow)*/
//                        .listRowSeparator(.hidden)
                }
                //.listStyle(.plain)
            } /// Also comment out this brace if you switch to use a List...
        }
    }
}

#Preview {
    MyClosetView()
}
