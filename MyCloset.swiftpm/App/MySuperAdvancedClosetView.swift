import SwiftUI

struct MySuperAdvancedClosetView: View {
    @EnvironmentObject var myCloset: MyCloset
    
    /*#-code-walkthrough(4.sheetstate)*/
    @State var isAddingItem = false
    /*#-code-walkthrough(4.sheetstate)*/

    var body: some View {
        /*#-code-walkthrough(4.stack)*/
        NavigationStack {
            /*#-code-walkthrough(4.stack)*/
            VStack {
                Text("My closet")
                    .font(.title)
                    .fontWidth(.compressed)
                    .padding()
                /// The `MySuperAdvancedClothingItemRowView` can change if an item is a favorite or not, so we need to pass a Binding, to let it change our data. This is why we add a `$` to `myCloset`, it tells SwiftUI we might be able to change the data in another View.
                /*#-code-walkthrough(4.listbinding)*/
                List($myCloset.clothingItems) { item in
                    /*#-code-walkthrough(4.listbinding)*/
                    MySuperAdvancedClothingItemRowView(clothingItem: item)
                    /*#-code-walkthrough(4.swipe)*/
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    myCloset.clothingItems.removeAll {$0.id == item.id }
                                }
                            } label: {
                                Text("Remove")
                            }
                        }
                    /*#-code-walkthrough(4.swipe)*/
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            /*#-code-walkthrough(4.toolbar)*/
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        /*#-code-walkthrough(4.toolbarbutton)*/
                        isAddingItem.toggle()
                        /*#-code-walkthrough(4.toolbarbutton)*/
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            /*#-code-walkthrough(4.toolbar)*/
            /*#-code-walkthrough(4.presentsheet)*/
            .sheet(isPresented: $isAddingItem) {
                AddClothingItemView()
            }
            /*#-code-walkthrough(4.presentsheet)*/
        }
    }
}

#Preview {
    MySuperAdvancedClosetView()
        .environmentObject(MyCloset())
}
