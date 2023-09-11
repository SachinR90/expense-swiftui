//
//  HomeScreen.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 20/09/22.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    // @EnvironmentObject var sideMenuState: SideMenuState
    @Environment(\.presentationMode) var presentation

    @State var selectedEntity: CDExpense?
    @State var showExpenseForm: Bool = false
    @State var showMonthYearFilter = false
    @StateObject var dateConfig: DateFilterConfig = .init()

    var body: some View {
        NavigationView {
            ZStack {
                Text("\(selectedEntity?.title ?? "")").hidden().frame(height: 0.0).opacity(0.0)
                VStack(alignment: .leading, spacing: 0) {
                    SectionedExpenseView(startDate: dateConfig.getStartDate(), endDate: dateConfig.getEndDate())
                        .onEntitySelected { cdExpense in
                            selectedEntity = cdExpense
                            showExpenseForm = true
                        }
                }
                .safeAreaInset(edge: .top) {
                    HomeFiltersView()
                        .padding(.bottom, nil)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        // Text view workaround for SwiftUI bug
                        // Keep toolbar items tappable after dismissing sheet
                        Text(showExpenseForm ? " " : "").hidden()
                        Button {
                            selectedEntity = nil
                            self.showExpenseForm = true
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                .sheet(isPresented: $showExpenseForm, onDismiss: {
                    selectedEntity = nil
                    showExpenseForm = false
                }, content: {
                    ExpenseFormView(entity: selectedEntity)
                }).navigationBarTitleDisplayMode(.inline)
            }
        }
        .environmentObject(dateConfig)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().previewLayout(.sizeThatFits)
    }
}
