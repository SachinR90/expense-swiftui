//
//  CategoryListView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 05/11/22.
//

import CoreData
import SwiftUI
struct CategoryListView: View {
    @FetchRequest(
        entity: CDCategory.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CDCategory.title, ascending: true)]
    )
    private var categories: FetchedResults<CDCategory>
    @Environment(\.managedObjectContext) private var context
    private var onItemSelection: ((CDCategory) -> Void)?
    @State private var refreshID = false // can be actually anything, but unique
    var body: some View {
        if categories.isEmpty {
            EmptyDataView(title: "No data found.")
                .padding(.all, 0)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else {
            List {
                ForEach(categories, id: \.objectID) { category in
                    Button(action: {
                        self.onItemSelection?(category)
                    }, label: {
                        CategoryListItemView(category: category, iconSize: 24.0)
                            .id(category.modifiedDate)
                    })
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .id(refreshID)
            .onDisappear(perform: { self.refreshID.toggle() })
        }
    }
}

extension CategoryListView {
    func onItemSelected(_ action: ((CDCategory) -> Void)?) -> CategoryListView {
        var view = self
        view.onItemSelection = action
        return view
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
