//
//  SwiftUIView.swift
//  
//
//  Created by Matthew Hanlon on 2/19/24.
//

import SwiftUI

/*#-code-walkthrough(7.searchscopeenum)*/
enum ClosetSearchScope: String, CaseIterable {
    case all
    case favorites = "♥️"
}
/*#-code-walkthrough(7.searchscopeenum)*/

struct MySuperScopedEditableSearchableAdvancedClosetView: View {
    @EnvironmentObject var myCloset: MyCloset
    
    @State var isAddingItem = false
    
    @State var searchText = ""
    /*#-code-walkthrough(7.searchscopestate)*/
    @State var searchScope = ClosetSearchScope.all
    /*#-code-walkthrough(7.searchscopestate)*/

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
                /*#-code-walkthrough(7.searchscope)*/
                .searchScopes($searchScope) {
                    ForEach(ClosetSearchScope.allCases, id: \.self) { scope in
                        Text(scope.rawValue.capitalized)
                    }
                }
                /*#-code-walkthrough(7.searchscope)*/
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
                    /*#-code-walkthrough(7.filter)*/
                    let isMatched = (
                        $0.name.localizedCaseInsensitiveContains(searchText.localizedLowercase) ||
                        $0.size.localizedCaseInsensitiveContains(searchText.localizedLowercase)
                    )
                    
                    return searchScope == .favorites ? isMatched && $0.isFavorite : isMatched
                    /*#-code-walkthrough(7.filter)*/
                }
            } set: { newValue in
                for item in newValue {
                    if let firstIndex = myCloset.clothingItems.firstIndex(where: { $0.id == item.id }) {
                        myCloset.clothingItems.insert(item, at: firstIndex)
                        myCloset.clothingItems.remove(at: firstIndex + 1)
                    }
                }
            }
        }
    }
}
#Preview {
    MySuperScopedEditableSearchableAdvancedClosetView()
        .environmentObject(MyCloset())
}
