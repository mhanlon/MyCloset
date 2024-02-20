import SwiftUI

struct MySuperEditableSearchableAdvancedClosetView: View {
    @EnvironmentObject var myCloset: MyCloset
    
    @State var isAddingItem = false
    
    @State var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("My closet")
                    .font(.title)
                    .fontWidth(.compressed)
                    .padding()
                List(searchResults) { item in
                    MySuperAdvancedClothingItemRowView(clothingItem: item)
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    myCloset.clothingItems.removeAll {$0.id == item.id }
                                }
                            } label: {
                                Text("Remove")
                            }
                            
                        }
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .searchable(text: $searchText)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAddingItem.toggle()
                        searchText = ""
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingItem) {
                AddClothingItemView()
            }
        }
    }
    
    var searchResults: Binding<[ClothingItem]> {
        if searchText.isEmpty {
            return $myCloset.clothingItems
        } else {
            return Binding {
                return myCloset.clothingItems.filter {
                    $0.name.localizedCaseInsensitiveContains(searchText.localizedLowercase) ||
                    $0.size.localizedCaseInsensitiveContains(searchText.localizedLowercase)
                }
                /*#-code-walkthrough(6.searchresults)*/
            } set: { newValue in
                /*#-code-walkthrough(6.searchresults.foreach)*/
                for item in newValue {
                    /*#-code-walkthrough(6.searchresults.foreach)*/
                    /*#-code-walkthrough(6.searchresults.iflet)*/
                    if let firstIndex = myCloset.clothingItems.firstIndex(where: { $0.id == item.id }) {
                        /*#-code-walkthrough(6.searchresults.iflet)*/
                        /*#-code-walkthrough(6.searchresults.insert)*/
                        myCloset.clothingItems.insert(item, at: firstIndex)
                        /*#-code-walkthrough(6.searchresults.insert)*/
                        /*#-code-walkthrough(6.searchresults.removeold)*/
                        myCloset.clothingItems.remove(at: firstIndex + 1)
                        /*#-code-walkthrough(6.searchresults.removeold)*/
                    }
                }
            }
            /*#-code-walkthrough(6.searchresults)*/
        }
    }
}

#Preview {
    MySuperEditableSearchableAdvancedClosetView()
        .environmentObject(MyCloset())
}
