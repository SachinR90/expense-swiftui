//
//  SummaryBreakDownListView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 16/11/22.
//

import CoreData
import SwiftUI

struct SummaryListView: View {
    var expensesWithoutCategory: FetchedResults<CDExpense>
    var categoriedExpenses: SectionedFetchResults<String?, CDExpense>
    var body: some View {
        List {
            ForEach(categoriedExpenses, id: \.id) { section in
                Section {
                    ForEach(section, id: \.modifiedDate) { expense in
                        SummaryListItemView(expense: expense)
                            .id(expense.modifiedDate)
                    }
                    .listRowInsets(EdgeInsets())
                } header: {
                    SummaryListHeaderView(title: "\(section.id ?? "")",
                                          subTitle: getTotalExpense(expenseList: Array(section)).toLocalCurrency())
                        .id(section.id)
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            Section {
                ForEach(expensesWithoutCategory, id: \.modifiedDate) { expense in
                    SummaryListItemView(expense: expense)
                        .id(expense.modifiedDate)
                }
                .listRowInsets(EdgeInsets())
            } header: {
                SummaryListHeaderView(title: "Non Categoried expense",
                                      subTitle: getTotalExpense(expenseList:
                                          Array(expensesWithoutCategory))
                                          .toLocalCurrency())
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }

    private func getTotalExpense(expenseList: [CDExpense]) -> Double {
        expenseList.reduce(0.0) {
            $1.type == .debit ? $0 + $1.amount : $0
        }
    }
}
