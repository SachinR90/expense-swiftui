//
//  CategoryForm.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 05/10/22.
//

import SwiftUI
import SymbolsPicker

enum CategoryFormFields {
    case title
    case color
}

struct CategoryFormView: View {
    var category: CDCategory?
    @FocusState private var focusField: CategoryFormFields?

    @Environment(\.managedObjectContext) private var managedContext
    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject private var model: CategoryFormViewModel = .init()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Title")
                        .fontWeight(.medium)
                    TextField("Enter title for expense", text: $model.title)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .focused($focusField, equals: .title)
                        .onSubmit {
                            focusField = .color
                        }
                        .submitLabel(.next)
                    Spacer().frame(height: 16)

                    ColorPicker(selection: $model.color, supportsOpacity: true) {
                        Text("Select Color").fontWeight(.medium)
                    }
                    SymbolPicker(symbol: $model.symbol, symbolColor: $model.color)
                }
                .padding([.horizontal], 8)
            }
            .navigationBarItems(
                leading: Button(action: self.onCancelTapped) { Text("Cancel") },
                trailing: Button(action: self.onSaveTapped) { Text("Save") }
            )
            .navigationBarTitle(model.cdCategory != nil ? "Edit Category" : "Add Category")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
        .interactiveDismissDisabled()
    }

    private func onCancelTapped() {
        presentationMode.wrappedValue.dismiss()
    }

    private func onSaveTapped() {
        model.saveCategory()
        presentationMode.wrappedValue.dismiss()
    }
}

extension CategoryFormView {
    init(entity: CDCategory? = nil) {
        category = entity
        if let entity = entity {
            model.setCategory(category: entity)
        }
    }
}

struct CagtegoryFormView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFormView().previewLayout(.sizeThatFits)
    }
}
