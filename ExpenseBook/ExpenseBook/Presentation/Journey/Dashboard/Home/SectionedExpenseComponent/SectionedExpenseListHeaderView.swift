//
//  SectionedExpenseListHeader.swift
//  ExpenseBook
//
//  Created by Sachin Rao on 21/10/22.
//

import SwiftUI

struct SectionedExpenseListHeaderView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .fontWeight(.medium)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(Color.clear)
    }
}
