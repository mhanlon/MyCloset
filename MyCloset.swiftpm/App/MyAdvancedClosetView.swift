import SwiftUI

struct MyAdvancedClosetView: View {
    /*#-code-walkthrough(3.environmentobject)*/
    @EnvironmentObject var myCloset: MyCloset
    /*#-code-walkthrough(3.environmentobject)*/

    
    var body: some View {
        VStack {
            Text("My closet")
                .font(.title)
                .fontWidth(.compressed)
                .padding()
            List(myCloset.clothingItems) { item in
                ClothingItemRowView(clothingItem: item)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    MyAdvancedClosetView()
        .environmentObject(MyCloset())
}
