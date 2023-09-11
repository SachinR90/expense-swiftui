//
//  SectionedExpenseHeaderView.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 21/10/22.
//

import SwiftUI
struct SectionedExpenseHeaderView: View {
    private var total: Double {
        totalRecived - totalPaid
    }

    var totalRecived: Double
    var totalPaid: Double

    let alertBalance = 25000.0
    let lowBalance = 4000.0

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Credits")
                        .font(.body)
                        .fontWeight(.medium)

                    Image(systemName: "arrow.down.backward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color.green)
                }
                Text("\(totalRecived.toLocalCurrency(decimalsDigits: 0, style: .currency))")
                    .font(.footnote)
                    .fontWeight(.regular)
            }

            Spacer()
            Text("-")
            Spacer()

            VStack(alignment: .leading) {
                HStack {
                    Text("Debits")
                        .font(.body)
                        .fontWeight(.medium)
                    Image(systemName: "arrow.up.forward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color.red)
                }
                Text("\(totalPaid.toLocalCurrency(decimalsDigits: 0, style: .currency))")
                    .font(.footnote)
                    .fontWeight(.regular)
            }

            Spacer()
            Text("=")
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text("Balance")
                        .font(.body)
                        .fontWeight(.medium)
                    Image(systemName: "equal.square")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundColor(total > alertBalance ?
                            Color.green
                            : total < lowBalance ?
                            Color.red : Color.orange)
                }
                Text("\(total.toLocalCurrency(decimalsDigits: 0, style: .currency))")
                    .foregroundColor(total > alertBalance ? Color.green : total < lowBalance ? Color.red : Color.orange)
                    .font(.footnote)
                    .fontWeight(.regular)
            }
        }
        .padding(.trailing, 20)
        .padding(.leading, 20)
    }
}
