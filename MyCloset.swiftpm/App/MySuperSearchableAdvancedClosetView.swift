import SwiftUI

struct MySuperSearchableAdvancedClosetView: View {
    @EnvironmentObject var myCloset: MyCloset
    
    @State var isAddingItem = false
    
    /*#-code-walkthrough(5.searchstate)*/
    @State var searchText = ""
    /*#-code-walkthrough(5.searchstate)*/
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("My closet")
                    .font(.title)
                    .fontWidth(.compressed)
                    .padding()
                /*#-code-walkthrough(5.searchablelist)*/
                List(searchResults) { item in
                    /*#-code-walkthrough(5.searchablelist)*/
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
                /*#-code-walkthrough(5.disabledrows)*/
                .disabled(!searchText.isEmpty)
                /*#-code-walkthrough(5.disabledrows)*/
                .listStyle(.plain)
                /*#-code-walkthrough(5.searchable)*/
                .searchable(text: $searchText)
                /*#-code-walkthrough(5.searchable)*/
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAddingItem.toggle()
                        /*#-code-walkthrough(5.clearsearchtext)*/
                        searchText = ""
                        /*#-code-walkthrough(5.clearsearchtext)*/
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
    
    /*#-code-walkthrough(5.searchresults)*/
    var searchResults: Binding<[ClothingItem]> {
        if searchText.isEmpty {
            return $myCloset.clothingItems
        } else {
            return Binding {
                return myCloset.clothingItems.filter {
                    $0.name.lowercased().contains(searchText.lowercased()) ||
                    $0.name.lowercased().contains(searchText.lowercased())
                }
            } set: { _ in }
        }
    }
    /*#-code-walkthrough(5.searchresults)*/
}

#Preview {
    MySuperSearchableAdvancedClosetView()
        .environmentObject(MyCloset())
}
