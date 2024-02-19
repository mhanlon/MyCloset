import SwiftUI

struct AddClothingItemView: View {
    @EnvironmentObject var myCloset: MyCloset

    /*#-code-walkthrough(4.dismiss)*/
    @Environment(\.dismiss) private var dismiss
    /*#-code-walkthrough(4.dismiss)*/

    /*#-code-walkthrough(4.newItem)*/
    @State var newItem = ClothingItem(name: "", size: "", isFavorite: false)
    /*#-code-walkthrough(4.newItem)*/

    var body: some View {
        Form {
            /// We use the `$` in front of `newItem` to let the TextFields and Toggle change the properties of the item.
            /*#-code-walkthrough(4.form)*/
            TextField("Name", text: $newItem.name)
            TextField("Size", text: $newItem.size)
            Toggle("Is Favorite?", isOn: $newItem.isFavorite)
            /*#-code-walkthrough(4.form)*/
            HStack {
                Spacer()
                /*#-code-walkthrough(4.save)*/
                Button("Add to Closet") {
                    myCloset.clothingItems.append(newItem)
                    dismiss()
                }
                /*#-code-walkthrough(4.save)*/
                .buttonStyle(.borderedProminent)
                Spacer()
                /*#-code-walkthrough(4.cancel)*/
                /*#-code-walkthrough(4.cancel)*/
                Button("Cancel") {
                    dismiss()
                }
                /*#-code-walkthrough(4.cancel)*/
                Spacer()
            }
            .padding()
        }
        .cornerRadius(12)
        .padding()
    }
}

#Preview {
    AddClothingItemView()
}
