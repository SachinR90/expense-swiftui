//
//  SummaryListItemView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 07/12/22.
//

import SwiftUI

struct SummaryListItemView: View {
    var expense: CDExpense
    var body: some View {
        HStack(alignment: .center) {
            Text(expense.title ?? "")
                .font(.footnote)
                .fontWeight(.medium)
            Spacer()

            Text(expense.amount.toLocalCurrency())
                .font(.footnote)
                .fontWeight(.medium)
        }
        .padding(.leading, 40)
        .padding(.trailing, 16)
        .frame(minHeight: 40)
    }
}
