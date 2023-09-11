//
//  InvestmentScreen.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 05/11/22.
//

import SwiftUI

struct InvestmentScreen: View {
    var body: some View {
        NavigationView {
            Text("NPS")

                .navigationTitle("Investment")
                .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct InvestmentScreen_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentScreen().previewLayout(.sizeThatFits)
    }
}
