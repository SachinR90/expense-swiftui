//
//  SectionedHeaderListItem.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 21/10/22.
//

import SwiftUI
struct SectionedExpenseListItemView: View {
    var expense: CDExpense
    var body: some View {
        HStack(alignment: .center) {
            if expense.category != nil {
                let color = expense.category?.color?.toColor()
                let symbol = expense.category!.symbol!

                Image(systemName: symbol)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(color)
            }
            Text(expense.title ?? "")
                .font(.callout)
                .foregroundColor(.black)
            Spacer()

            Text("\(expense.amount.toLocalCurrency())")
                .font(.callout)
                .foregroundColor(.black)
            Image(systemName: expense.type == .credit ? "arrow.down.backward" : "arrow.up.forward")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 10, height: 10)
                .foregroundColor(expense.type == .credit ? Color.green : Color.red)
        }
        .padding(.leading, 40)
        .padding(.trailing, 16)
        .frame(minHeight: 40)
    }
}
