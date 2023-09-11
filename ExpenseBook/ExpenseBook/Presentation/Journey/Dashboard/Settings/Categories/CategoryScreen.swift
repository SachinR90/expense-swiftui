//
//  CategoryScreen.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 05/10/22.
//

import SwiftUI
struct CategoryScreen: View {
    @State var showCategorySheet: Bool = false
    @State var selectedEntity: CDCategory?
    var body: some View {
        ZStack {
            Text("\(selectedEntity?.title ?? "")").hidden().frame(height: 0.0).opacity(0.0)
            CategoryListView()
                .onItemSelected { category in
                    selectedEntity = category
                    showCategorySheet = true
                }
                .navigationTitle(Text("Category"))
                .navigationBarTitleDisplayMode(.automatic)
                .navigationBarItems(
                    trailing:
                    Button {
                        showCategorySheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                ).sheet(isPresented: $showCategorySheet, onDismiss: {
                    showCategorySheet = false
                    selectedEntity = nil
                }, content: {
                    CategoryFormView(entity: selectedEntity)
                })
        }
    }
}
